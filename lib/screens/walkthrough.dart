import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/selection_page.dart';

class WalkThrough extends StatelessWidget {
  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Onboarding(
      background: Colors.white,
      proceedButtonStyle: ProceedButtonStyle(
          proceedButtonPadding: EdgeInsets.all(8.0),
          proceedButtonColor: DEFAULT_COLOR,
          proceedpButtonText: Text(
            'Proceed',
            style: GoogleFonts.montserrat(fontSize: 15, color: Colors.white),
          ),
          proceedButtonRoute: (context) {
            _storeOnBoardInfo();
            return Get.offAll(() => SelectionPage());
          }),
      skipButtonStyle: SkipButtonStyle(
          skipButtonPadding:
              EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          skipButtonColor: DEFAULT_COLOR),
      pages: onboardingPagesList,
      isSkippable: true,
      indicator: Indicator(
        indicatorDesign: IndicatorDesign.polygon(
          polygonDesign: PolygonDesign(
              polygon: DesignType.polygon_circle,
              polygonRadius: 5.0,
              polygonSpacer: 25.0),
        ),
      ),
    ));
  }
}

final onboardingPagesList = [
  PageModel(
    widget: Column(
      children: [
        Expanded(
          child:
              Image.asset('assets/illustration 1.png', width: 200, height: 200),
        ),
        Text(
          'Get the right Job you deserve',
          style: GoogleFonts.montserrat(fontSize: 18),
        ),
        SizedBox(height: 10.0),
        Text('Easily Search for jobs and attend interviews on the go ',
            style: GoogleFonts.montserrat(fontSize: 13.5)),
        SizedBox(height: 30.0),
      ],
    ),
  ),
  PageModel(
    widget: Column(
      children: [
        Expanded(
          child: Image.asset(
            'assets/illustration 2.png',
            width: 200,
            height: 200,
          ),
        ),
        Text('Attend to Job Interview on the go.',
            style: GoogleFonts.montserrat(fontSize: 18)),
        SizedBox(height: 10.0),
        Text(
            'Your Dream Job is a step away when you Attend  to interview invite',
            style: GoogleFonts.montserrat(fontSize: 13.5)),
        SizedBox(height: 30.0),
      ],
    ),
  ),
  PageModel(
    widget: Column(
      children: [
        Expanded(
          child: Image.asset(
            'assets/illustration 1.png',
            width: 200,
            height: 200,
          ),
        ),
        Text('New Offers are waiting for you',
            style: GoogleFonts.montserrat(fontSize: 17)),
        SizedBox(height: 10.0),
        Text('job Offers uploaded from verified companies every minute',
            style: GoogleFonts.montserrat(fontSize: 13.5)),
        SizedBox(height: 30.0),
      ],
    ),
  ),
];
