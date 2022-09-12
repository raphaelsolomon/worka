// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/interfaces/login_interface.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/walkthrough.dart';
import 'main_screens/main_nav.dart';

String finalToken = '';
String avatar = '';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<String> getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedOnboard = prefs.getString('token') ?? '';
    context.read<Controller>().setAvatar(prefs.getString(AVATAR) ?? '');
    context.read<Controller>().setUserName(
        '${prefs.getString(FIRSTNAME.capitalizeFirst!) ?? ''} ${prefs.getString(LASTNAME.capitalizeFirst!) ?? ''}');
    setState(() {
      finalToken = obtainedOnboard;
      avatar = prefs.getString(AVATAR) ?? '';
    });
    return (finalToken);
  }

  @override
  void initState() {
    execute();
    getValidationData().then((value) async {
      Timer(
          const Duration(seconds: 4),
          () => ILogin().getType().then((value) => {
                if (value.isNotEmpty)
                  {
                    if (value == 'employer')
                      {Get.offAll(() => EmployerNav())}
                    else
                      {Get.offAll(() => const MainNav())}
                  }
                else
                  {Get.offAll(() => WalkThrough())}
              }));
    });
    super.initState();
  }

  void execute() async {
    String token = await ILogin().getToken();
    if (token != null) {
      ILogin().getType().then((value) => {
            if (value == 'employer')
              {}
            else
              {
                context.read<Controller>().getRelative_JobTags(),
              }
          });
      context.read<Controller>().setToken(token, await ILogin().getType());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/logo1.png',
                  height: 190,
                  width: 190,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: DEFAULT_COLOR,
                ))
          ],
        ),
      )),
    );
  }
}
