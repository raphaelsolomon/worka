import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/employer_page/payment_queue.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:worka/phoenix/model/UserResponse.dart';

class RePaymentiOS extends StatefulWidget {
  const RePaymentiOS({super.key});

  @override
  State<RePaymentiOS> createState() => _RePaymentiOSState();
}

class _RePaymentiOSState extends State<RePaymentiOS> {
  String plan = '';
  String key = '';

  bool platform = Platform.isIOS;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchaseDetails> purchaseDetailsList = [];
  var paymentWrapper = SKPaymentQueueWrapper();

  String reference = 'Free';
  final Set<String> _kIds = <String>{
    '_worka_silver_plan',
    '_worka_gold_plan',
    '_worka_diamond_plan'
  };
  Map<String, Map<String, dynamic>> _PLAN_PRICE = {
    'Free': {
      'price': '',
      'plan': '20220322',
      'intro': 'Perfect for starters',
      'color': Colors.black87.withOpacity(.6),
      'duration': 'Annually',
      'isSelected': false,
      'features': [
        'Access to five(5) shortlisted staff',
        'Access to unlimited choice of candidate',
        'Access to interview five(5) candidates',
        'Access to online test/interview',
        'Free access to candidate anywhere in the world'
      ]
    },
  };

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

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    this.purchaseDetailsList = purchaseDetailsList;
    for (var p in purchaseDetailsList) {
      if (p.status == PurchaseStatus.pending) {
      } else if (p.status == PurchaseStatus.error) {
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text:
              '${p.error!.code}\n${p.error!.details['NSLocalizedDescription']}',
          onConfirmBtnTap: () {
            setState(() => _PLAN_PRICE[key]!['isSelected'] = false);
            Navigator.pop(context);
          },
        );
      } else if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        verifyReceipt(p);
      } else if (p.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(p);
      }
    }
  }

  verifyReceipt(product) async {
    print(this.purchaseDetailsList.length);
    final response = await validateReceiptIos(product, true);
    if (response.statusCode == 200) {
      updatePlan(plan, '${product.productID}_${_getReference()}', context);
    }
    setState(() => _PLAN_PRICE[key]!['isSelected'] = false);
  }

  Future<http.Response> validateReceiptIos(
      PurchaseDetails product, isTest) async {
    final String url = isTest
        ? 'https://sandbox.itunes.apple.com/verifyReceipt'
        : 'https://buy.itunes.apple.com/verifyReceipt';
    return await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'receipt-data': product.verificationData.localVerificationData,
        'exclude-old-transactions': true,
        'password': '34da729c80794089871f4dc9cb358f2e'
      }),
    );
  }

  @override
  void initState() {
    initStoreInfo();
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      InAppPurchase.instance.isAvailable().then((available) {
        if (available == true) {
          InAppPurchase.instance.queryProductDetails(_kIds).then((value) {
            if (value.notFoundIDs.isNotEmpty) {
              // Handle the error.
            }
            value.productDetails.forEach((product) {
              setState(() {
                if (product.id == '_worka_diamond_plan') {
                  _PLAN_PRICE.putIfAbsent(
                      'Diamond',
                      () => {
                            'price': 'N20000.00',
                            'plan': '40151001',
                            'intro': 'Perfect for companies',
                            'ID': '_worka_diamond_plan',
                            'color': Color(0xFFFF6B01),
                            'duration': 'Annually',
                            'isSelected': false,
                            'details': product,
                            'features': [
                              'Unlimited access to shortlisted staffs',
                              'Unlimited access to choice of candidates',
                              'Unlimited access to test/interview candidates',
                              'Unlimited access to candidates anywhere in the world'
                            ]
                          });
                } else if (product.id == '_worka_gold_plan') {
                  _PLAN_PRICE.putIfAbsent(
                      'Gold Premium',
                      () => {
                            'price': 'N10000.00',
                            'plan': '12900320',
                            'ID': '_worka_gold_plan',
                            'intro': 'Perfect for companies',
                            'color': Color(0xFFFF6B01),
                            'duration': 'Annually',
                            'isSelected': false,
                            'details': product,
                            'features': [
                              'Access to twenty(20) shortlisted staffs',
                              'Access to unlimited choice of candidate',
                              'Access to interview twenty(20) candidates',
                              'Access to online test/interview',
                              'Free access to candidate anywhere in the world'
                            ]
                          });
                } else {
                  _PLAN_PRICE.putIfAbsent(
                      'Silver Premium',
                      () => {
                            'price': '5000.00',
                            'plan': '32282003',
                            'intro': 'Best fit for companies',
                            'color': Color(0xFF0039A5),
                            'ID': '_worka_silver_plan',
                            'duration': 'Annually',
                            'isSelected': false,
                            'details': product,
                            'features': [
                              'Access to ten(10) shortlisted staff',
                              'Access to unlimited choice of candidate',
                              'Access to interview ten(10) candidates',
                              'Access to online test/interview',
                              'Free access to candidate anywhere in the world'
                            ]
                          });
                }
              });
            });
          });
        }
      });

      _subscription = purchaseUpdated.listen((event) {
        _listenToPurchaseUpdated(event);
      },
          onDone: () => _subscription.cancel(),
          onError: (error) => print(error));
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeStore();
    _subscription.cancel();
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
                  ..._PLAN_PRICE.entries.map((e) {
                    var index = purchaseDetailsList.indexWhere((element) =>
                        element.productID == '${_PLAN_PRICE['ID']}');
                    return Container(
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
                                        color: _PLAN_PRICE[e.key]!['color'],
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text('${_PLAN_PRICE[e.key]!['price']}',
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
                                child: Text('${_PLAN_PRICE[e.key]!['intro']}',
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
                          ..._PLAN_PRICE[e.key]!['features'].map((e) => Column(
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
                                        '${e}',
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
                          (index > -1 &&
                                  purchaseDetailsList[index].status ==
                                      PurchaseStatus.purchased)
                              ? purchaseDate(DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(purchaseDetailsList[index]
                                          .transactionDate!))))
                              : _PLAN_PRICE[e.key]!['isSelected']
                                  ? CircularProgressIndicator(
                                      color: DEFAULT_COLOR,
                                    )
                                  : GestureDetector(
                                      onTap: () => selectButton(
                                          '${_PLAN_PRICE[e.key]!['plan']}',
                                          '${_PLAN_PRICE[e.key]!['price']}',
                                          _PLAN_PRICE[e.key]!['details'],
                                          e.key),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(15.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1.0,
                                                color: DEFAULT_COLOR,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              color: DEFAULT_COLOR
                                                  .withOpacity(.06)),
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
                    );
                  })
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }

  selectButton(plan, price, product, key) async {
    this.plan = plan;
    this.key = key;
    var transactions = await paymentWrapper.transactions();
    setState(() => _PLAN_PRICE[key]!['isSelected'] = true);
    if (plan.toLowerCase() == 'free') {
      updatePlan(plan, _getReference()!, context);
      return;
    }
    //pending transaction is available then cancel
    transactions.forEach((transaction) async {
      await paymentWrapper.finishTransaction(transaction);
    });
    //proceed to payment transaction
    executeIOS(product);
  }

  executeIOS(ProductDetails productDetail) async {
    try {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetail);
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {}
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
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error',
          text: e.toString());
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

  purchaseDate(date) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: DEFAULT_COLOR.withOpacity(.1),
          ),
          borderRadius: BorderRadius.circular(6.0),
          color: DEFAULT_COLOR.withOpacity(.06)),
      child: Center(
        child: Text(
          '$date',
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14.0),
        ),
      ));
}
