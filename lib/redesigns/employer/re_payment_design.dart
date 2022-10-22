import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RePaymentAndroid extends StatefulWidget {
  const RePaymentAndroid({super.key});

  @override
  State<RePaymentAndroid> createState() => _RePaymentAndroidState();
}

class _RePaymentAndroidState extends State<RePaymentAndroid> {
  @override
  void initState() {
    super.initState();
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
                            Container(
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
                                        fontSize: 15.0, color: DEFAULT_COLOR, fontWeight: FontWeight.w700),
                                  ),
                                )),
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
}
