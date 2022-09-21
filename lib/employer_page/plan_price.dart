import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/employer_page/payment_queue.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import '../phoenix/Controller.dart';
import '../phoenix/dashboard_work/Success.dart';
import '../phoenix/model/Constant.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import '../phoenix/model/UserResponse.dart';

class PlanPrice extends StatefulWidget {
  const PlanPrice({Key? key}) : super(key: key);

  @override
  State<PlanPrice> createState() => _PlanPriceState();
}

class _PlanPriceState extends State<PlanPrice> {
  String reference = '';
  bool isLoading = false;
  bool isScrolled = false;
  String plan = '';
  final plugin = PaystackPlugin();
  final _scrollController = ScrollController();
  bool platform = Platform.isIOS;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Map<String, Map<String, dynamic>> PLAN_PRICE = {
    'Free': {
      'price': '0.00',
      'plan': '20220322',
      'color': Colors.black,
      'duration': 'Annually',
      'details': ProductDetails(currencyCode: 'USD', description: '', id: '', price: '0.00', title: '', rawPrice: 0.00),
      'features': [
        'Access to five(5) shortlisted staff',
        'Access to unlimited choice of candidate',
        'Access to interview five(5) candidates',
        'Access to online test/interview',
        'Free access to candidate anywhere in the world'
      ]
    },
    'Silver Premium': {
      'price': '5000.00',
      'plan': '32282003',
      'ID': '_worka_silver_plan',
      'color': Color(0xFFC0C0C0),
      'duration': 'Annually',
      'details': ProductDetails(currencyCode: 'USD', description: 'Worka Silver Plan', id: '_worka_silver_plan', price: '\$10.99', title: '', rawPrice: 10.99),
      'features': [
        'Access to ten(10) shortlisted staff',
        'Access to unlimited choice of candidate',
        'Access to interview ten(10) candidates',
        'Access to online test/interview',
        'Free access to candidate anywhere in the world'
      ]
    },
    'Gold Premium': {
      'price': '10000.00',
      'plan': '12900320',
      'ID': '_worka_gold_plan',
      'color': Color(0xFFFFD700),
      'duration': 'Annually',
      'details': ProductDetails(currencyCode: 'USD', description: 'Worka Gold Plan', id: '_worka_gold_plan', price: '\$21.99', title: '', rawPrice: 21.99),
      'features': [
        'Access to twenty(20) shortlisted staffs',
        'Access to unlimited choice of candidate',
        'Access to interview twenty(20) candidates',
        'Access to online test/interview',
        'Free access to candidate anywhere in the world'
      ]
    },
    'Diamond': {
      'price': '20000.00',
      'plan': '40151001',
      'ID': '_worka_diamond_plan',
      'color': Color(0xFFB9F2FF),
      'duration': 'Annually',
      'details': ProductDetails(currencyCode: 'USD', description: 'Worka Diamond Plan', id: '_worka_diamond_plan', price: '\$43.99', title: '', rawPrice: 43.99),
      'features': [
        'Unlimited access to shortlisted staffs',
        'Unlimited access to choice of candidates',
        'Unlimited access to test/interview candidates',
        'Unlimited access to candidates anywhere in the world'
      ]
    }
  };

  @override
  void initState() {
    plugin.initialize(publicKey: PUBLIC_KEY);
    initStoreInfo();
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    SchedulerBinding.instance.addPostFrameCallback((_) { 
      _subscription = purchaseUpdated.listen((event) {
        _listenToPurchaseUpdated(event);
      }, onDone: () => _subscription.cancel(), onError: (error) => print(error));
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeStore();
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
  if (Platform.isIOS) {
    var iosPlatformAddition = _inAppPurchase
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
  }
}


Future<void> disposeStore() async {
  if (Platform.isIOS) {
    var iosPlatformAddition = _inAppPurchase
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    await iosPlatformAddition.setDelegate(null);
  }
}

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var p in purchaseDetailsList) {
      if(!p.pendingCompletePurchase) continue;

        InAppPurchase.instance.completePurchase(p).then((value) {
          updatePlan(plan, '${p.productID}_${_getReference()}', context);
        });
    }
  }



  @override
  Widget build(BuildContext context) {
    _inAppPurchase.purchaseStream.listen(
        (List<PurchaseDetails> purchaseDetailsList) {
      print(purchaseDetailsList.length);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: isScrolled
            ? FloatingActionButtonLocation.startDocked
            : FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            onPressed: () {
              if (!isScrolled) {
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn);
                isScrolled = true;
              } else {
                _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn);
                isScrolled = false;
              }
              setState(() {});
            },
            backgroundColor: DEFAULT_COLOR,
            child: Icon(!isScrolled ? Icons.arrow_forward : Icons.arrow_back,
                color: Colors.white),
          ),
        ),
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace),
                          color: DEFAULT_COLOR,
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Text('',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.blue),
                          textAlign: TextAlign.center),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(null),
                          color: Colors.transparent,
                          onPressed: null,
                        ),
                      ),
                    ]),
                Text('Choose Your Plan',
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: DEFAULT_COLOR),
                    textAlign: TextAlign.center),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListView.builder(
                      itemCount: PLAN_PRICE.keys.toList().length,
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemBuilder: (c, i) {
                        var key = PLAN_PRICE.keys.toList();
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child:
                                _listPlan(context, PLAN_PRICE[key[i]], key[i]));
                      }),
                ))
              ],
            )));
  }

  _listPlan(BuildContext c, Map<String, dynamic>? plan_price, String e) {
    List<String> features = plan_price!['features'];
    Color color = plan_price['color'];
    return Container(
      width: 320,
      padding: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.2),
                offset: const Offset(0.0, 4.0),
                spreadRadius: 0.8,
                blurRadius: 20.0)
          ]),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Text(
            '$e Plan',
            style: GoogleFonts.cinzel(
                fontSize: 18.0, fontWeight: FontWeight.w400, color: color),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 10.0),
                child: Text(
                  'NGN',
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black26),
                ),
              ),
              Flexible(
                child: AutoSizeText(
                  '${plan_price['price']}',
                  maxLines: 1,
                  style: GoogleFonts.montserrat(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      letterSpacing: 0.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            '${plan_price['duration']}',
            style: GoogleFonts.poppins(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Colors.black26),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: Colors.black12,
          ),
          const SizedBox(height: 20.0),
          Text(
            'Features: ',
            style: GoogleFonts.cinzel(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: features
                    .map((e) => Column(
                          children: [
                            Text('- $e',
                                style: GoogleFonts.cinzel(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20.0),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
          Visibility(
              visible: e != 'Free',
              child: selectButton(context, '${plan_price['plan']}', '${plan_price['price']}', plan_price['details']))
        ],
      ),
    );
  }

  selectButton(BuildContext context, String plan, String price, ProductDetails ID) =>
      GestureDetector(
        onTap: () async {
          this.plan = plan;
          if (plan.toLowerCase() == 'free') {
            updatePlan(plan, _getReference()!, context);
            return;
          }
          platform
              ? executeIOS(ID)
              : chargeCard(context, price, context.read<Controller>().email);
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: DEFAULT_COLOR),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select this plan',
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: 14.0),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18.0,
                )
              ],
            )),
      );

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

  // ignore: unused_element
  Future<String?> _fetchAccessCodeFrmServer(email, charge) async {
    String url = 'https://api.paystack.co/transaction/initialize';
    String? accessCode;
    try {
      final response = await http.post(Uri.parse(url),
          body: {"email": "$email", "amount": "$charge"},
          headers: {"Authorization": "Bearer $SECRET_KEY"});
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        accessCode = parsed['data']['access_code'];
        reference = parsed['data']['reference'];
      }
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      print(e.toString());
    }
    return accessCode;
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

  executeIOS(ProductDetails productDetail) async {
    try {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetail);
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {}
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
