// ignore_for_file: unnecessary_null_comparison

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/reuseables/general_forget_password_text.dart';
import 'package:worka/reuseables/general_header.dart';
import 'package:worka/reuseables/general_password_textfield.dart';
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
    return SafeArea(
      child: Scaffold(
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
        body: ListView(
          children: [
            const GeneralHeader(
              input1: 'Welcome Back.',
              paddingTop: 50,
              paddingRight: 100,
              paddingBottom: 0,
              paddingLeft: 100,
              input2: 'Login with your email or \n     your Social Media',
              paddingTop2: 12,
              paddingRight2: 50,
              paddingLeft2: 50,
              paddingBottom2: 0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomAuthForm('Email', 'Email', TextInputType.text,
                        ctl: emailController),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GeneralPasswordTextField(
                      passwordController: passwordController,
                      input1: 'Password',
                      input2: 'password',
                    ),
                  ),
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
                      padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
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
                                  style: GoogleFonts.montserrat(
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
                          'Don\'t Have An Account? ',
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => SelectionPage());
                          },
                          child: Text('Create Account',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, color: DEFAULT_COLOR)),
                        )
                      ],
                    ),
                  ),
                  // GeneralButtonContainer(
                  //   paddingRight: 55,
                  //   paddingTop: 25,
                  //   paddingLeft: 55,
                  //   paddingBottom: 100,
                  //   name: 'Login',
                  //   onPress: () async {
                  //     final form = _formKey.currentState!;
                  //     if (form.validate()) {
                  //       processing = true;
                  //
                  //       UserModel? user = await _loginService.login(
                  //           passwordController.text, emailController.text);
                  //
                  //       if (user != null) {
                  //         final SharedPreferences sharedPreferences =
                  //             await SharedPreferences.getInstance();
                  //         sharedPreferences.setString('email', user.email);
                  //         sharedPreferences.setString('token', user.token);
                  //         Get.to(() => HomePage(user: user));
                  //         setState(() {
                  //           processing = false;
                  //         });
                  //         debugPrint('Hello');
                  //         debugPrint(user.token);
                  //         debugPrint(user.email);
                  //       } else {
                  //         debugPrint('Hello');
                  //         debugPrint(user?.token);
                  //
                  //         Get.to(() => const InterviewPage());
                  //         setState(() {
                  //           processing = false;
                  //         });
                  //       }
                  //     }
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
