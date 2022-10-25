import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/employer_page/employer_sign.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
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
        body: Column(
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
            Image.asset(
                  'assets/black.png',
                  width: 260.0,
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
              const SizedBox(height: 10.0,),
           
            Text(
              'Select your profile type.',
              style: GoogleFonts.lato(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Hire Talents or Get job Interview',
              style: GoogleFonts.lato(
                  fontSize: 13.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                context.read<Controller>().changeSelectionPage("Employer");
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: .7,
                        color: context.watch<Controller>().selectionPage ==
                                "Employer"
                            ? DEFAULT_COLOR
                            : DEFAULT_COLOR.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      'Employer',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: DEFAULT_COLOR),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                context.read<Controller>().changeSelectionPage("Employee");
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: .7,
                        color: context.watch<Controller>().selectionPage ==
                                "Employee"
                            ? DEFAULT_COLOR
                            : DEFAULT_COLOR.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      'Job Seeker',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: DEFAULT_COLOR),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 18.0),
              child: Text('Choose an option to proceed',
                  style:
                      GoogleFonts.lato(color: Colors.black87, fontSize: 13.0),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 30.0,),
            GestureDetector(
              onTap: () {
                if (context.read<Controller>().selectionPage == "Employee") {
                  Get.to(() => const RegistrationPage());
                } else {
                  Get.to(() => EmployerSignUp());
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: DEFAULT_COLOR),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style:
                          GoogleFonts.lato(fontSize: 15.0, color: Colors.white),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () => Get.to(() => const LoginScreen()),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: ' Login',
                            style: GoogleFonts.lato(
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
                    style: GoogleFonts.lato(
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
                    style: GoogleFonts.lato(
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
                    style: GoogleFonts.lato(
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
