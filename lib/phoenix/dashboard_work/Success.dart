import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../GeneralButtonContainer.dart';

class Success extends StatelessWidget {
  final String text;
  final imageAsset;
  final Function? callBack;
  const Success(this.text,
      {this.imageAsset = 'assets/succ.png', this.callBack, Key? key})
      : super(key: key);

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
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 1.0, color: Colors.blue.withOpacity(.2))),
              child: Image.asset('assets/succ.png'),
            ),
            SizedBox(height: 20.0),
            Text('${text}',
                style:
                    GoogleFonts.montserrat(color: DEFAULT_COLOR, fontSize: 18)),
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
                  callBack!();
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
