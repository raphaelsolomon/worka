import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/reset_password.dart';

import '../phoenix/Controller.dart';
import '../phoenix/CustomScreens.dart';
import '../phoenix/dashboard_work/preview.dart';
import '../screens/notification.dart';
import 'employer_delete_account.dart';

class EmployerSettings extends StatefulWidget {
  const EmployerSettings({Key? key}) : super(key: key);

  @override
  _EmployerSettingsState createState() => _EmployerSettingsState();
}

class _EmployerSettingsState extends State<EmployerSettings> {
  @override
  void initState() {
    context.read<Controller>().fetchNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 5.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: const Icon(Icons.keyboard_backspace),
                color: DEFAULT_COLOR,
                onPressed: () => Get.back(),
              ),
            ),
            Text('Settings',
                style: GoogleFonts.lato(fontSize: 18, color: DEFAULT_COLOR),
                textAlign: TextAlign.center),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(null))
          ]),
          buildPaddingChoice('Change Password', const Color(0xff4F4F4F), () {
            Get.to(() => ResetPassword());
          }),
          buildPaddingChoice('About Us', const Color(0xff4F4F4F), () {
            Get.to(() => Screens(about(context)));
          }),
          buildPaddingChoice('Privacy Policy', const Color(0xff4F4F4F), () {
            Get.to(() => Screens(privacy(context)));
          }),
          buildPaddingChoice('Notification Settings', const Color(0xff4F4F4F),
              () => Get.to(() => NotificationPage())),
          buildPaddingChoice('Terms of use', const Color(0xff4F4F4F), () {
            Get.to(() => Screens(termOfUse(context)));
          }),
          InkWell(
            onTap: () {
              Get.to(() => const EmployerDeleteAccount());
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(34, 30, 0, 0),
              child: Text(
                'Delete Account',
                style: GoogleFonts.montserrat(
                    fontSize: 15.0, color: Color(0xffDB1F1F)),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  buildPaddingChoice(String text, Color color, callBack) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 30, 0, 0),
      child: InkWell(
        onTap: () => callBack(),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
              fontSize: 15.0,
              color: const Color(0xff4F4F4F),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
