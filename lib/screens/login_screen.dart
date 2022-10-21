// ignore_for_file: unnecessary_null_comparison

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/re_company_profile.dart';
import 'package:worka/reuseables/general_forget_password_text.dart';
import 'package:worka/screens/forget_password.dart';
import 'package:worka/screens/main_screens/main_nav.dart';
import 'package:worka/screens/selection_page.dart';
import 'package:cool_alert/cool_alert.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool hidePassword = true;
  bool isPassword = true;
  bool processing = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff0D30D9),
            ),
            onPressed: () => Get.offAll(() => SelectionPage()),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                  'assets/editted.png',
                  width: 200.0,
                  height: 80.0,
                  fit: BoxFit.contain,
                ),
              const SizedBox(height: 10.0,),
              Text(
                'Welcome Back',
                style: GoogleFonts.lato(
                    fontSize: 25.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Login with your email',
                style: GoogleFonts.lato(
                    fontSize: 13.5,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: getCardForm('Username', 'JohnDeo@gmail.com',
                    ctl: emailController),
              ),
                const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: getCardFormPassword('Password', 'Password',
                    ctl: passwordController),
              ),
              Column(
                children: [
                  GeneralForgetPasswordText(
                    input: 'Forgot Password?',
                    onPress: () => Get.to(() => const ForgetPassword()),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text.isEmpty) {
                        Get.snackbar(
                            'Required', 'Pls Enter your email address');
                      } else if (passwordController.text.isEmpty) {
                        Get.snackbar('Required', 'Pls Enter your password');
                      } else {
                        setState(() {
                          processing = true;
                        });
        
                        var s = await context.read<Controller>().userLogin(
                            emailController.text, passwordController.text);
                        if (s == 'success') {
                          setState(() {
                            processing = false;
                          });
                          CoolAlert.show(
                              context: context,
                              barrierDismissible: false,
                              type: CoolAlertType.success,
                              text: "Login Successful",
                              onConfirmBtnTap: () {
                                Get.offAll(() => context
                                            .read<Controller>()
                                            .userResponse!
                                            .user ==
                                        'employer'
                                    ? EmployerNav()
                                    : const MainNav());
                              });
                        } else if (s == 'error') {
                          setState(() {
                            processing = false;
                          });
                          CoolAlert.show(
                            barrierDismissible: false,
                            context: context,
                            type: CoolAlertType.error,
                            text: "Invalid Login details",
                            onConfirmBtnTap: () {
                              Get.back();
                              setState(() {
                                processing = false;
                              });
                            },
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff0D30D9)),
                          child: processing
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Please Wait...',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                )
                              : Text(
                                  'Login',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Need an Account? ',
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => SelectionPage());
                          },
                          child: Text('Sign Up',
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: DEFAULT_COLOR,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
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
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      hidePassword = !hidePassword;
                    }),
                    color: Colors.black,
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
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
