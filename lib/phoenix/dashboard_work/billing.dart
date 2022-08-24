import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/numeric_keyboard.dart';
import '../../reuseables/general_button_container.dart';
import '../Controller.dart';
import '../CustomScreens.dart';
import '../model/Constant.dart';
import 'Success.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final plugin = PaystackPlugin();
  String first = '0.00';
  String price = '';
  bool platform = Platform.isIOS;

  @override
  void initState() {
    plugin.initialize(publicKey: PUBLIC_KEY);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: DEFAULT_COLOR,
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Billing',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: DEFAULT_COLOR),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.transparent,
                    onPressed: null,
                  ),
                ),
              ]),
              const SizedBox(height: 5.0),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 10.0),
                                child: Text(
                                  'NGN',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black26),
                                ),
                              ),
                              Text(
                                price == '' ? first : '${price}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    letterSpacing: 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      NumericKeyboard(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        onKeyboardTap: (s) {
                          setState(() {
                            price = price + s;
                          });
                        },
                        rightButtonFn: () {
                          setState(() {
                            price = price.substring(0, price.length - 1);
                          });
                        },
                        rightIcon: Icon(Icons.backspace, color: DEFAULT_COLOR),
                        textColor: Colors.black87,
                      ),
                      const SizedBox(height: 10.0),
                      // platform
                      //     ? isNotEmpty('${price}')
                      //         ? ApplePayButton(
                      //             width: MediaQuery.of(context).size.width,
                      //             height: 45.0,
                      //             paymentConfigurationAsset: 'pay.json',
                      //             paymentItems: [plugin],
                      //             style: ApplePayButtonStyle.whiteOutline,
                      //             type: ApplePayButtonType.buy,
                      //             margin: const EdgeInsets.symmetric(
                      //                 horizontal: 25.0),
                      //             onPaymentResult: (data) {
                      //               updatePlan(
                      //                   '${data['token']}_${DateTime.now().toIso8601String()}',
                      //                   context);
                      //             },
                      //             loadingIndicator: const Center(
                      //               child: CircularProgressIndicator(),
                      //             ),
                      //           )
                      //         : const SizedBox()
                          GeneralButtonContainer(
                              paddingHeight: 50,
                              paddingWidth: MediaQuery.of(context).size.width,
                              name: 'Pay',
                              onPress: () {
                                if (price == '') {
                                  CustomSnack('Error', 'Please enter a price');
                                  return;
                                }
                                chargeCard(context, '${price}');
                              },
                              paddingLeft: 20,
                              paddingTop: 15,
                              paddingRight: 20,
                              radius: 10,
                              paddingBottom: 20),
                    ]),
              )
            ],
          )),
    );
  }

  bool isNotEmpty(String value) {
    if (value == '') {
      CustomSnack('Error', 'Please enter a price');
      return false;
    }
    return true;
  }

  chargeCard(BuildContext context, String price) async {
    String email = '${context.read<Controller>().email.trim()}';
    Charge charge = Charge()
      ..amount = double.tryParse('${price}')!.toInt() * 100
      ..reference = _getReference()
      //..accessCode = await _fetchAccessCodeFrmServer(email, '${price}00')
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
      fullscreen: false,
      logo: Image.asset(
        'assets/logo.png',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
    final reference = response.reference;

    // Checking if the transaction is successful
    if (response.status) {
      _verifyOnServer(reference);
    } else {
      CustomSnack('Error', response.message);
    }
  }

  void _verifyOnServer(ref) async {
    String url = 'https://api.paystack.co/transaction/verify/$ref';
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $SECRET_KEY"});
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        if (parsed['message'] == "Verification successful") {
          updatePlan(ref, context);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePlan(ref, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('${ROOT}payment/record/$ref'),
          headers: {
            "Authorization": "TOKEN ${context.read<Controller>().token}"
          });
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        if (parsed['response'] == "successfull") {
          Get.off(() => Success('Payment Successful', callBack: () {
                Navigator.pop(context);
              }));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

String? _getReference() {
  String platform;
  if (Platform.isIOS) {
    platform = 'iOS';
  } else {
    platform = 'Android';
  }
  return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
}
