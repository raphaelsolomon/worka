import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:worka/screens/login_screen.dart';

import '../phoenix/model/Constant.dart';

// ignore: prefer_typing_uninitialized_variables
var response;
void registerUser(String firstname, String middlename, String surname,
    String email, var contact, String password, String confirmPassword) async {
  final url = Uri.parse('${ROOT}users/');
  var request = http.MultipartRequest('POST', url);
  request.fields['phone'] = contact;
  request.fields['first_name'] = surname;
  request.fields['last_name'] = firstname;
  request.fields['other_name'] = middlename;
  request.fields['account_type'] = 'employee';
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['re_password'] = confirmPassword;
  response = await request.send();
  if (response.statusCode == 201 || response.statusCode == 200) {
    Get.defaultDialog(
        title: 'Registration Successful',
        titleStyle: const TextStyle(
            fontSize: 20,
            color: Color(0xff0D30D9),
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        barrierDismissible: false,
        middleText:
            'Complete your registration by verifying the mail sent to your Email',
        middleTextStyle: const TextStyle(
          fontSize: 15,
        ),
        textConfirm: 'OK',
        onConfirm: () {
          Get.to(() => const LoginScreen());
        });
  } else {
    Get.defaultDialog(
      title: 'Registration Not  Successful',
      titleStyle: const TextStyle(
          fontSize: 20,
          color: Color(0xff0D30D9),
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
      //middleText: 'Complete your registration by verifying the mail sent to your Email',
      middleTextStyle: const TextStyle(
        fontSize: 15,
      ),
    );
  }
}
