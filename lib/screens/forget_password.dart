import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../phoenix/CustomScreens.dart';
import '../phoenix/GeneralButtonContainer.dart';
import '../phoenix/Resusable.dart';
import 'package:http/http.dart' as http;

import '../phoenix/dashboard_work/Success.dart';
import '../phoenix/model/Constant.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Text('Forget Password ',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: Color(0xff0D30D9))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Colors.black,
                  onPressed: null,
                ),
              )
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/emailsent.png'),
                  Form(
                      key: formKey,
                      child: CustomTextForm(emailController, 'Email', 'Email',
                          TextInputType.emailAddress)),
                  GeneralButtonContainer(
                    name: 'Continue',
                    color: Colors.red,
                    textColor: Colors.white,
                    onPress: () {
                      if (emailController.text.trim().isNotEmpty &&
                          emailController.text.contains('@')) {
                        setState(() {
                          isLoading = true;
                        });
                        execute();
                      } else {
                        CustomSnack('Error', 'Enter a valid email address');
                      }
                    },
                    paddingBottom: 3,
                    paddingLeft: 30,
                    paddingRight: 30,
                    paddingTop: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void execute() async {
    try {
      final res = await http.Client().post(
          Uri.parse('${ROOT}users/set_password/'),
          body: {'email': emailController.text.trim()});
      if (res.statusCode == 204) {
        Get.off(() => Success(
              'Reset Link has been sent to this email address',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
    } on Exception {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
