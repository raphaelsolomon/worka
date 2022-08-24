import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../phoenix/Controller.dart';
import '../phoenix/CustomScreens.dart';
import '../phoenix/GeneralButtonContainer.dart';
import 'package:http/http.dart' as http;
import '../phoenix/dashboard_work/Success.dart';
import '../phoenix/model/Constant.dart';
import '../reuseables/general_password_textfield.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  TextEditingController oldPassword = TextEditingController();

  TextEditingController newPassword = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
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
              Text('Reset Password',
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
                      child: Column(
                        children: [
                          GeneralPasswordTextField(
                            passwordController: oldPassword,
                            input1: 'Current Password',
                            input2: 'Current Password',
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          GeneralPasswordTextField(
                            passwordController: newPassword,
                            input1: 'New Password',
                            input2: 'New Password',
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          GeneralPasswordTextField(
                            passwordController: confirmPassword,
                            input1: 'Confirm Password',
                            input2: 'Confirm Password',
                          ),
                        ],
                      )),
                  GeneralButtonContainer(
                    name: 'Continue',
                    color: Colors.red,
                    textColor: Colors.white,
                    onPress: () {
                      if (oldPassword.text.trim().isEmpty) {
                        CustomSnack('Error', 'Enter old password');
                        return;
                      }

                      if (newPassword.text.trim().isEmpty) {
                        CustomSnack('Error', 'Enter new password');
                        return;
                      }

                      if (confirmPassword.text.trim().isEmpty) {
                        CustomSnack('Error', 'Confirm new password');
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      execute();
                    },
                    paddingBottom: 3,
                    paddingLeft: 30,
                    paddingRight: 30,
                    paddingTop: 25,
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
      final res = await http.Client()
          .post(Uri.parse('${ROOT}users/set_password/'), body: {
        'new_password': newPassword.text.trim(),
        're_new_password': confirmPassword.text.trim(),
        'current_password': oldPassword.text.trim()
      }, headers: {
        'Authorization': 'TOKEN ${context.read<Controller>().token}'
      });
      if (res.statusCode == 204) {
        Get.off(() => Success(
              'Password successfully updated',
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
