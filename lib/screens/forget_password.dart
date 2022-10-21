import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../phoenix/CustomScreens.dart';
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
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: DEFAULT_COLOR,
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text('Forget Password ',
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
                              width: .5, color: DEFAULT_COLOR.withOpacity(.5))),
                      child: Image.asset(
                        'assets/forget.png',
                        width: MediaQuery.of(context).size.width,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Your Password will be reset\nusing  your email',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.lato(fontSize: 15.0, color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: getCardForm('Email Address', 'johndoe@example.com',
                        ctl: emailController),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
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
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.symmetric(horizontal: 40.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DEFAULT_COLOR),
                        child: Center(
                          child: Text(
                            'Request',
                            style: GoogleFonts.lato(
                                fontSize: 15.0, color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
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
              decoration: InputDecoration(
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
