import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../phoenix/Controller.dart';
import '../phoenix/CustomScreens.dart';
import 'package:http/http.dart' as http;
import '../phoenix/dashboard_work/Success.dart';
import '../phoenix/model/Constant.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool cPasswordVisible = false;

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
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Text('Create New Password',
                  style: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.black87)),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.symmetric(horizontal: 50.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.06),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                width: .5,
                                color: DEFAULT_COLOR.withOpacity(.5))),
                        child: Image.asset(
                          'assets/forget.png',
                          width: MediaQuery.of(context).size.width,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: getCardFormPassword(
                        'Old Password',
                        'Old Password',
                        ctl: oldPassword,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: getCardFormPassword(
                        'New Password',
                        'New Password',
                        ctl: newPassword,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: getCardFormPassword(
                        'Confirm New Password',
                        'Confirm New Password',
                        ctl: confirmPassword,
                      ),
                    ),
                    const SizedBox(
                      height: 45.0,
                    ),
                    isLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: DEFAULT_COLOR),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
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
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: DEFAULT_COLOR),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0, color: Colors.white),
                                  ),
                                )),
                          ),
                  ],
                ),
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

  getCardFormPassword(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              obscureText: oldPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      
                      if (oldPasswordVisible) {
                        oldPasswordVisible = false;
                      } else {
                        oldPasswordVisible = true;
                      }
                    }),
                    color: Colors.black,
                    icon: Icon(
                      oldPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  getCardFormPassword1(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              obscureText: newPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                     
                      if (newPasswordVisible) {
                        newPasswordVisible = false;
                      } else {
                        newPasswordVisible = true;
                      }
                    }),
                    color: Colors.black,
                    icon: Icon(
                      newPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  getCardFormPassword2(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              obscureText: cPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      if (cPasswordVisible) {
                        cPasswordVisible = false;
                      } else {
                        cPasswordVisible = true;
                      }
                    }),
                    color: Colors.black,
                    icon: Icon(
                      cPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }
}
