import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/models/InterviewObj.dart';
import 'package:worka/models/InterviewTheory.dart';
import 'package:worka/models/interviewData.dart';
import 'package:worka/phoenix/dashboard_work/interview/startObjective.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:http/http.dart' as http;
import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import 'startTheory.dart';

class InterviewWelcome extends StatefulWidget {
  final bool b;
  final String? id;
  InterviewWelcome(this.b, this.id, {Key? key}) : super(key: key);

  @override
  _InterviewWelcomeState createState() => _InterviewWelcomeState();
}

class _InterviewWelcomeState extends State<InterviewWelcome> {
  InterviewTheory? myTheory;
  InterviewObj? oModel;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    widget.b ? executeTheory(context) : executeObj(context);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  executeObj(BuildContext context) async {
    try {
      final res = await Dio().get(
          '${ROOT}interview/view_obj_questions/${widget.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        setState(() {
          oModel = InterviewObj.fromJson(res.data);
        });
        print(oModel);
      }
    } on SocketException {
      CustomSnack('Error', 'check internet connection...');
    } on Exception {
      CustomSnack('Error', 'unable to fetch information...');
    }
  }

  executeTheory(BuildContext context) async {
    try {
      final res = await Dio().get(
          '${ROOT}interview/view_theory_questions/${widget.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        setState(() {
          myTheory = InterviewTheory.fromJson(res.data);
        });
        print(myTheory);
      }
    } on SocketException {
      CustomSnack('Error', 'check internet connection...');
    } on Exception {
      CustomSnack('Error', 'unable to fetch information...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //custom app design
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace),
                          color: Color(0xff0D30D9),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(null),
                          color: Colors.black,
                          onPressed: null,
                        ),
                      )
                    ]),
                SizedBox(height: 30.0),
                //end of app bar design

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hi, ${context.watch<Controller>().profileModel!.firstName} ${context.watch<Controller>().profileModel!.lastName} ${context.watch<Controller>().profileModel!.otherName}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    'You’re few steps away from\n getting '
                                    'hired.',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17, color: DEFAULT_COLOR),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),
                          //the guides
                          Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Follow the following Instructions to kick start your Interview',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    FutureBuilder(
                                        future: fetchData(),
                                        builder: (ctx, snap) =>
                                            _container(snap)),
                                    widget.b
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                top: 40.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                              child: myTheory != null
                                                  ? myTheory!.submitted == true
                                                      ? Container(
                                                          width: 300,
                                                          child:
                                                              GeneralButtonContainer(
                                                            name: 'Applied',
                                                            color: Colors.grey,
                                                            textColor:
                                                                Colors.white,
                                                            onPress: () => null,
                                                            paddingBottom: 3,
                                                            paddingLeft: 10,
                                                            paddingRight: 10,
                                                            paddingTop: 5,
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 300,
                                                          child:
                                                              GeneralButtonContainer(
                                                            name: 'Start Now',
                                                            color: Color(
                                                                0xff0D30D9),
                                                            textColor:
                                                                Colors.white,
                                                            onPress: () {
                                                              executeForTheory();
                                                            },
                                                            paddingBottom: 3,
                                                            paddingLeft: 10,
                                                            paddingRight: 10,
                                                            paddingTop: 5,
                                                          ),
                                                        )
                                                  : Container(),
                                            ),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                              child: oModel != null
                                                  ? oModel!.submitted == true
                                                      ? Container(
                                                          width: 300,
                                                          child:
                                                              GeneralButtonContainer(
                                                            name: 'Applied',
                                                            color: Colors.grey,
                                                            textColor:
                                                                Colors.white,
                                                            onPress: () => null,
                                                            paddingBottom: 3,
                                                            paddingLeft: 10,
                                                            paddingRight: 10,
                                                            paddingTop: 5,
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 300,
                                                          child:
                                                              GeneralButtonContainer(
                                                            name: 'Start Now',
                                                            color: Color(
                                                                0xff0D30D9),
                                                            textColor:
                                                                Colors.white,
                                                            onPress: () =>
                                                                executeForObjective(),
                                                            paddingBottom: 3,
                                                            paddingLeft: 10,
                                                            paddingRight: 10,
                                                            paddingTop: 5,
                                                          ),
                                                        )
                                                  : Container(),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 30.0,
                                    )
                                  ])),
                        ]),
                  ),
                )
              ],
            )));
  }

  executeForTheory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(myTheory!.interviewUid!)) {
      String data = prefs.getString(myTheory!.interviewUid!) ?? '{}';
      Map<String, dynamic> encoded = jsonDecode(data);
      Duration timer = parseDuration(encoded['timer']);
      Map answer = encoded['answer'];
      if (_connectionStatus != ConnectionState.none) {
        Get.off(() => TheoryInterview(myTheory!, timer, answer));
      } else {
        CustomSnack('Error', 'Check Internet Connection...');
      }
    } else {
      Duration d = Duration(minutes: myTheory!.timerSec!);
      if (_connectionStatus != ConnectionState.none) {
        Get.off(() => TheoryInterview(myTheory!, d, {}));
      } else {
        CustomSnack('Error', 'Check Internet Connection...');
      }
    }
  }

  executeForObjective() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(oModel!.interviewUid!)) {
      String data = prefs.getString(oModel!.interviewUid!) ?? '{}';
      Map<String, dynamic> encoded = jsonDecode(data);
      Duration timer = parseDuration(encoded['timer']);
      Map<String?, dynamic> answer = encoded['answer'];
      if (_connectionStatus != ConnectionState.none) {
        Get.off(() => ObjectiveInterview(oModel!, timer, answer));
      } else {
        CustomSnack('Error', 'Check Internet Connection...');
      }
    } else {
      Duration d = Duration(minutes: oModel!.timerSec!);
      if (_connectionStatus != ConnectionState.none) {
        Get.off(() => ObjectiveInterview(oModel!, d, {}));
      } else {
        CustomSnack('Error', 'Check Internet Connection...');
      }
    }
  }

  Future<InterviewData?> fetchData() async {
    InterviewData? interviewAllModel;
    final res = await http.Client().get(
        Uri.parse('${ROOT}interview/employee_view_interview/${widget.id}'),
        headers: {
          'Authorization': 'TOKEN ${context.read<Controller>().token}'
        });
    if (res.statusCode == 200) {
      final parsed = json.decode(res.body);
      interviewAllModel = InterviewData.fromMap(parsed);
    }
    return interviewAllModel;
  }

  Widget _container(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Expanded(
            child: Center(
                child: Text('Error',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center)));
      } else if (snapshot.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'Interview Title',
              style:
                  GoogleFonts.montserrat(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(
              height: 7.0,
            ),
            AutoSizeText('${snapshot.data!.title}',
                style: GoogleFonts.montserrat(
                    fontSize: 15, color: Colors.black87)),
            const SizedBox(
              height: 20.0,
            ),
            AutoSizeText(
              'Interview Type',
              style:
                  GoogleFonts.montserrat(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(
              height: 7.0,
            ),
            AutoSizeText('${snapshot.data!.interviewType}',
                style: GoogleFonts.montserrat(
                    fontSize: 15, color: Colors.black87)),
            const SizedBox(
              height: 20.0,
            ),
            snapshot.data!.timer == true
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Interview Time',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black45),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        AutoSizeText('${snapshot.data!.timerSec} Minutes',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, color: Colors.black87)),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                : Container(),
            AutoSizeText(
              'Interview Note',
              style:
                  GoogleFonts.montserrat(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(
              height: 7.0,
            ),
            AutoSizeText('${snapshot.data!.note}',
                style:
                    GoogleFonts.montserrat(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.justify),
            const SizedBox(
              height: 45.0,
            ),
          ],
        );
      } else {
        return Expanded(
            child: Center(
                child: Text('No Instructions',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center)));
      }
    } else {
      return Expanded(
          child: Center(child: Text('State: ${snapshot.connectionState}')));
    }
  }

  Duration parseDuration(String s) {
    List<String> parts = s.split(':');
    String seconds = parts[parts.length - 3].split('.')[0];
    return Duration(
        hours: int.parse(parts[parts.length - 3]),
        minutes: int.parse(parts[parts.length - 2]),
        seconds: int.parse(seconds));
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
}
