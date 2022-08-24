import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/main_screens/main_nav.dart';

class InterviewResult extends StatelessWidget {
  final String scores;
  const InterviewResult(this.scores, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.all(8.0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: DEFAULT_COLOR.withOpacity(.2), width: 1.0),
                  borderRadius: BorderRadius.circular(100.0)),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: DEFAULT_COLOR.withOpacity(.5), width: 1.0),
                    borderRadius: BorderRadius.circular(100.0)),
                child: Center(
                  child: Text(
                    'Score : ${scores}',
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GeneralButtonContainer(
                name: 'Continue',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () {
                  Get.off(() => MainNav());
                },
                paddingBottom: 3,
                paddingLeft: 20,
                paddingRight: 20,
                paddingTop: 5,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
