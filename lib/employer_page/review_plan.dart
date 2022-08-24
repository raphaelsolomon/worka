import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
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
  final _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
        floatingActionButtonLocation: isScrolled
            ? FloatingActionButtonLocation.startDocked
            : FloatingActionButtonLocation.endDocked,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              children: [
                const SizedBox(height: 5.0),
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
                Text('Plan review',
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
      height: MediaQuery.of(c).size.height,
      padding: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
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
                fontSize: 18.0, fontWeight: FontWeight.bold, color: color),
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
            visible: e == 'Free',
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: DEFAULT_COLOR,
                    ),
                  )
                : selectButton(context, '${e}'),
          )
        ],
      ),
    );
  }

  executeToServer(mapData) async {
    setState(() {
      isLoading = true;
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
        isLoading = false;
      });
    }
  }

  selectButton(BuildContext context, String plan) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), color: DEFAULT_COLOR),
      child: InkWell(
        onTap: () {
          executeToServer(widget.mapData);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select this plan',
              style:
                  GoogleFonts.montserrat(color: Colors.white, fontSize: 14.0),
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
        ),
      ));
}
