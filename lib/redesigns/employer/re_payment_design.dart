import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/UserResponse.dart';

class RePaymentAndroid extends StatefulWidget {
  const RePaymentAndroid({super.key});

  @override
  State<RePaymentAndroid> createState() => _RePaymentAndroidState();
}

class _RePaymentAndroidState extends State<RePaymentAndroid> {
  String reference = '';
  bool isLoading = false;
  bool isScrolled = false;
  String plan = '';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: PUBLIC_KEY);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Payment Plans',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54))
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('Choose Payment Plan',
                  style: GoogleFonts.lato(
                      fontSize: 22.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('Select the Offer you best need',
                  style: GoogleFonts.lato(
                      fontSize: 12.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400)),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(children: [
                  ...PLAN_PRICE.entries.map((e) => Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Color(0xFFC7C7C7).withOpacity(.2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 14.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text('${e.key}'.toUpperCase(),
                                      style: GoogleFonts.lato(
                                          fontSize: 19.0,
                                          color: PLAN_PRICE[e.key]!['color'],
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text('${PLAN_PRICE[e.key]!['price']}',
                                    style: GoogleFonts.lato(
                                        fontSize: 20.0,
                                        color: Colors.black87.withOpacity(.6),
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text('${PLAN_PRICE[e.key]!['intro']}',
                                      style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Text('/annum',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.lato(
                                        fontSize: 12.0,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ...List.generate(
                                PLAN_PRICE[e.key]!['features'].length,
                                (i) => Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 21.0,
                                              color: Color(0xFF00D0BC),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Flexible(
                                                child: Text(
                                              '${PLAN_PRICE[e.key]!['features'][i]}',
                                              style: GoogleFonts.lato(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                      ],
                                    )),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () => selectButton(
                                  context,
                                  '${PLAN_PRICE[e.key]!['plan']}',
                                  '${PLAN_PRICE[e.key]!['price']}',
                                  PLAN_PRICE[e.key]!['details']),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(15.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: DEFAULT_COLOR,
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                      color: DEFAULT_COLOR.withOpacity(.06)),
                                  child: Center(
                                    child: Text(
                                      'Choose Plan',
                                      style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: DEFAULT_COLOR,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ))
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }

  selectButton(BuildContext context, plan, price, detils) {
    this.plan = plan;
    if (plan.toLowerCase() == 'free') {
      updatePlan(plan, _getReference()!, context);
      return;
    }
    chargeCard(context, price, context.read<Controller>().email);
  }

  void _verifyOnServer(ref) async {
    String url = 'https://api.paystack.co/transaction/verify/$ref';
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $SECRET_KEY"});
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        if (parsed['message'] == "Verification successful") {
          updatePlan(plan, ref, context);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePlan(String plan, String ref, BuildContext context) async {
    try {
      final response = await http.Client()
          .get(Uri.parse('${ROOT}plan_upgrade/$plan/$ref'), headers: {
        "Authorization": 'TOKEN ${context.read<Controller>().token}'
      });
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        var p = Plan.fromMap(parsed);
        Get.off(() => Success('Plan upgrade sucessfully', callBack: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString(PLAN, json.encode(p.toMap()));
              Get.back();
            }));
      }
    } catch (e) {
      print(e.toString());
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

  chargeCard(BuildContext context, String price, String email) async {
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
}
