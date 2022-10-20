import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/employer_page/employer_sign.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/reuseables/general_button_container.dart';
import 'package:worka/reuseables/general_container.dart';
import 'package:provider/provider.dart';
import 'package:worka/screens/help_center.dart';
import 'package:worka/screens/login_screen.dart';
import 'package:worka/screens/registration_page.dart';

import '../phoenix/CustomScreens.dart';
import '../phoenix/dashboard_work/preview.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace,
                      color: DEFAULT_COLOR,
                    ),
                    onPressed: () => Get.back())
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Worka.',
              style: GoogleFonts.lato(fontSize: 14.0, color: DEFAULT_COLOR),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'Select your profile type.',
              style: GoogleFonts.lato(fontSize: 14.0, color: DEFAULT_COLOR),
            ),
            GeneralContainer(
              name: 'EMPLOYER',
              onPress: () {
                //Get.to(() => const EmployerSignUp()
                context.read<Controller>().changeSelectionPage("Employer");
              },
              paddingLeft: 55,
              paddingTop: 101,
              paddingRight: 55,
              paddingBottom: 0,
              width: 200,
              height: 50,
              bcolor: context.watch<Controller>().selectionPage == "Employer"
                  ? const Color(0xff0D30D9)
                  : Colors.transparent,
              stroke: 1.5,
              size: 14,
            ),
            GeneralContainer(
                name: 'APPLICANT',
                paddingLeft: 55,
                paddingRight: 55,
                paddingTop: 11,
                paddingBottom: 0,
                width: 200,
                height: 45,
                size: 14,
                bcolor: context.watch<Controller>().selectionPage == "Employee"
                    ? const Color(0xff0D30D9)
                    : Colors.transparent,
                stroke: 1.5,
                onPress: () {
                  //
                  context.read<Controller>().changeSelectionPage("Employee");
                }),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Choose an option to proceed',
                  style: GoogleFonts.montserrat(
                      color: const Color(0xffBDBDBD), fontSize: 13.0),
                  textAlign: TextAlign.center),
            ),
            GeneralButtonContainer(
                paddingWidth: 200,
                paddingHeight: 45,
                name: 'Get Started',
                paddingLeft: 55,
                paddingTop: 19,
                paddingRight: 55,
                paddingBottom: 25,
                radius: 10,
                onPress: () {
                  if (context.read<Controller>().selectionPage == "Employee") {
                    Get.to(() => const RegistrationPage());
                  } else {
                    Get.to(() => EmployerSignUp());
                  }
                }),
            GestureDetector(
              onTap: () => Get.to(() => const LoginScreen()),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                      children: [
                        TextSpan(
                            text: ' Login',
                            style: GoogleFonts.montserrat(
                                color: const Color(0xff0D30D9),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1)),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => Screens(termOfUse(context)));
                  },
                  child: Text(
                    'Terms of Use',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0, color: DEFAULT_COLOR),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Help_Center());
                  },
                  child: Text(
                    'Help Center',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0, color: DEFAULT_COLOR),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Screens(privacy(context)));
                  },
                  child: Text(
                    'About Us',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0, color: DEFAULT_COLOR),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
