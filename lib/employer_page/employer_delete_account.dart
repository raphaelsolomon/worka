import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/reuseables/general_button_container.dart';
import 'package:worka/reuseables/general_header.dart';
import 'package:http/http.dart' as http;
import '../phoenix/Controller.dart';
import '../phoenix/CustomScreens.dart';
import '../phoenix/dashboard_work/Success.dart';
import '../phoenix/model/Constant.dart';
import '../reuseables/general_password_textfield.dart';
import '../screens/selection_page.dart';
import 'controller/empContoller.dart';

class EmployerDeleteAccount extends StatefulWidget {
  const EmployerDeleteAccount({Key? key}) : super(key: key);

  @override
  _EmployerDeleteAccountState createState() => _EmployerDeleteAccountState();
}

class _EmployerDeleteAccountState extends State<EmployerDeleteAccount> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<bool> onBack() async {
    // Get.offAll(() => SelectionPage());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              child: Column(
                children: [
                  const GeneralHeader(
                    input1: 'Delete Account',
                    paddingLeft: 100,
                    paddingRight: 100,
                    paddingTop: 31,
                    paddingBottom: 0,
                    input2:
                        'Please confirm if you want \n your account deleted from our system',
                    paddingLeft2: 52,
                    paddingRight2: 45,
                    paddingTop2: 100,
                    paddingBottom2: 39,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GeneralPasswordTextField(
                      passwordController: emailController,
                      input1: 'Password',
                      input2: 'Password',
                    ),
                  ),

                  // CustomAuthForm('Email Address', 'Email Address',
                  //   TextInputType.emailAddress,
                  //   ctl: emailController),
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : GeneralButtonContainer(
                          paddingWidth: MediaQuery.of(context).size.width,
                          paddingHeight: 45,
                          radius: 10,
                          name: 'Delete Account',
                          onPress: () {
                            if (emailController.text.trim().isEmpty) {
                              CustomSnack(
                                  'Error',
                                  'password field must not be '
                                      'empty');
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              execute();
                            }
                          },
                          paddingLeft: 55,
                          paddingTop: 40,
                          paddingRight: 55,
                          paddingBottom: 26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void execute() async {
    try {
      final res = await http.Client().post(Uri.parse('${ROOT}delete_account/'),
          body: {
            'password': emailController.text.trim()
          },
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        Get.offAll(() => Success(
              'Account deleted successfully',
              callBack: () async {
                SharedPreferences s = await SharedPreferences.getInstance();
                s.clear();
                context.read<EmpController>().signOut();
                context.read<Controller>().logout();
                Get.offAll(() => SelectionPage());
              },
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet connection..');
    } on Exception {
      CustomSnack('Error', 'Could not submit request..');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
