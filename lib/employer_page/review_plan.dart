import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/controllers/constants.dart';
import '../phoenix/model/Constant.dart';
import '../screens/login_screen.dart';

class ReviewPlanPrice extends StatefulWidget {
  final Map mapData;
  const ReviewPlanPrice(this.mapData, {Key? key}) : super(key: key);

  @override
  State<ReviewPlanPrice> createState() => _ReviewPlanPriceState();
}

class _ReviewPlanPriceState extends State<ReviewPlanPrice> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(children: [
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
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: [
                  ...PLAN_PRICE.entries.map((e) => _listPlan(context, e.key))
                ]),
              )),
            ])));
  }

  _listPlan(BuildContext c, String e) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                child: Text('${e}'.toUpperCase(),
                    style: GoogleFonts.lato(
                        fontSize: 19.0,
                        color: PLAN_PRICE[e]!['color'],
                        fontWeight: FontWeight.w600)),
              ),
              Text('${PLAN_PRICE[e]!['amount']}',
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
                child: Text('${PLAN_PRICE[e]!['intro']}',
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
              PLAN_PRICE[e]!['features'].length,
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
                            '${PLAN_PRICE[e]!['features'][i]}',
                            style: GoogleFonts.lato(
                                fontSize: 12.0, color: Colors.black54),
                          ))
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  )),
          const SizedBox(
            height: 20.0,
          ),
          Visibility(
            visible: e == 'Free',
            child: PLAN_PRICE[e]!['isLoading'] == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(color: DEFAULT_COLOR),
                    ),
                  )
                : GestureDetector(
                    onTap: () =>
                        selectButton(context, '${PLAN_PRICE[e]!['plan']}', e),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  executeToServer(mapData, String key) async {
    print(widget.mapData);
    setState(() {
      PLAN_PRICE[key]!['isLoading'] = true;
    });
    final url = Uri.parse('${ROOT}addemployer/');
    try {
      final response = await http.Client().post(url, body: mapData);
      if (response.statusCode == 200) {
        CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.success,
            text:
                "Complete your registration by verifying the mail sent to your Email",
            onConfirmBtnTap: () {
              Get.off(() => const LoginScreen());
            });
      } else {
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: response.body.toString(),
          onConfirmBtnTap: () {
            Get.back();
          },
        );
      }
    } on SocketException {
    } finally {
      setState(() {
        PLAN_PRICE[key]!['isLoading'] = false;
      });
    }
  }

  void selectButton(BuildContext context, String plan, String e) {
    executeToServer(widget.mapData, e);
  }
}
