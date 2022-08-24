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
import 'package:worka/phoenix/countDown.dart';
import 'package:worka/phoenix/dashboard_work/interview/interviewResult.dart';
import 'package:worka/phoenix/model/Constant.dart';
import '../../../employer_page/controller/empContoller.dart';
import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import 'interviewPreview.dart';

class ObjectiveInterview extends StatefulWidget {
  final InterviewObj oModel;
  final Duration oDuration;
  final Map<String?, dynamic> oMap;
  ObjectiveInterview(this.oModel, this.oDuration, this.oMap);
  @override
  State<ObjectiveInterview> createState() => _ObjectiveInterviewState();
}

class _ObjectiveInterviewState extends State<ObjectiveInterview> {
  final controller = TextEditingController();
  int counter = 0;
  bool iscompleted = false;
  Duration duration = Duration(hours: 0, minutes: 0, microseconds: 400);
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    context.read<EmpController>().addAllAnswers(widget.oMap);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _item = widget.oModel.objInterviewQuestion;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //custom app design
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Questions',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                        '$counter of ${widget.oModel.objInterviewQuestion!.length}',
                        style: GoogleFonts.montserrat(
                            fontSize: 13, color: Colors.black26),
                        textAlign: TextAlign.center))
              ]),
              SizedBox(height: 10.0),
              //end of app bar design
              widget.oModel.timer == true
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: DEFAULT_COLOR),
                          child: Countdown(
                              duration: widget.oDuration,
                              onFinish: () {
                                executeObj(
                                    context.read<EmpController>().objAnswers,
                                    widget.oModel.interviewUid);
                              },
                              builder: (ctx, remaining) {
                                this.duration = remaining;
                                saveBackground(remaining);
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    '${remaining.inHours} : ${remaining.inMinutes} : ${remaining.inSeconds.remainder(60)}',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      height: 1.2,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //greeting oluwatomi
                        Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Answer the Question below',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),

                        //the guides
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: itemList(
                                  context, _item![counter], _item.length)),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        // iscompleted
                        //     ? Container()
                        //     : Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         child: Visibility(
                        //           visible: false,
                        //           child: GeneralButtonContainer(
                        //             name: 'Preview',
                        //             color: Color(0xff0D30D9),
                        //             textColor: Colors.white,
                        //             onPress: () {
                        //               Get.to(() => InterviewPreview(
                        //                     context
                        //                         .read<EmpController>()
                        //                         .objAnswers,
                        //                     oModel: widget.oModel,
                        //                   ));
                        //             },
                        //             paddingBottom: 3,
                        //             paddingLeft: 30,
                        //             paddingRight: 30,
                        //             paddingTop: 5,
                        //           ),
                        //         )),
                        // SizedBox(
                        //   height: 30.0,
                        // ),
                      ]),
                ),
              )
            ],
          ),
        ),
    );
  }

  void saveBackground(Duration remaining) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.oModel.interviewUid!)) {
      prefs.remove(widget.oModel.interviewUid!);
    }
    Map<String, dynamic> _mapString = {
      'timer': remaining.toString(),
      'answer': context.read<EmpController>().objAnswers
    };
    prefs.setString(widget.oModel.interviewUid!, jsonEncode(_mapString));
  }

  void executeObj(Map data, id) async {
    try {
      final res = await Dio().post('${ROOT}interview/submit_obj_answer/$id',
          data: {'answers': jsonEncode(data)},
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => InterviewResult(res.data['score']));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to submit interview');
    } finally {
      context.read<EmpController>().clearObj();
    }
  }

  Widget itemList(BuildContext context, ObjInterviewQuestion e, int size) {
    Map<String?, dynamic> answer = context.read<EmpController>().objAnswers;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border:
                  Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.2))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: AutoSizeText('${e.question}',
                            minFontSize: 12,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                                fontSize: 16, color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      Radio<bool>(
                        value: e.sub_answer == e.options!.split(',')[0] ||
                            answer[e.questionUid] == e.options!.split(',')[0],
                        groupValue: true,
                        onChanged: (b) {
                          if (answer.containsKey(e.questionUid)) {
                            return;
                          }
                          setState(() {
                            e.setSubAnswer(e.options!.split(',')[0]);
                          });
                        },
                      ),
                      Flexible(
                          child: Text('${e.options!.split(',')[0].trim()}',
                              style: _style))
                    ],
                  ),
                  SizedBox(height: 45.0),
                  Row(
                    children: [
                      Radio<bool>(
                        value: e.sub_answer == e.options!.split(',')[1] ||
                            answer[e.questionUid] == e.options!.split(',')[1],
                        groupValue: true,
                        onChanged: (b) {
                          if (answer.containsKey(e.questionUid)) {
                            return;
                          }
                          setState(() {
                            e.setSubAnswer(e.options!.split(',')[1]);
                          });
                        },
                      ),
                      Flexible(
                          child: Text('${e.options!.split(',')[1].trim()}',
                              style: _style))
                    ],
                  ),
                  SizedBox(height: 45.0),
                  Row(
                    children: [
                      Radio<bool>(
                        value: e.sub_answer == e.options!.split(',')[2] ||
                            answer[e.questionUid] == e.options!.split(',')[2],
                        groupValue: true,
                        onChanged: (b) {
                          if (answer.containsKey(e.questionUid)) {
                            return;
                          }
                          setState(() {
                            e.setSubAnswer(e.options!.split(',')[2]);
                          });
                        },
                      ),
                      Flexible(
                          child: Text('${e.options!.split(',')[2].trim()}',
                              style: _style))
                    ],
                  ),
                  SizedBox(height: 45.0),
                  Row(
                    children: [
                      Radio<bool>(
                        value: e.sub_answer == e.options!.split(',')[3] ||
                            answer[e.questionUid] == e.options!.split(',')[3],
                        groupValue: true,
                        onChanged: (b) {
                          if (answer.containsKey(e.questionUid)) {
                            return;
                          }
                          setState(() {
                            e.setSubAnswer(e.options!.split(',')[3]);
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          '${e.options!.split(',')[3].trim()}',
                          style: _style,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 100.0),
                  Row(
                    children: [
                      Visibility(
                        visible: counter > 0,
                        child: Flexible(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GeneralButtonContainer(
                              name: 'Back',
                              color: Color(0xff0D30D9),
                              textColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  counter = counter - 1;
                                });
                              },
                              paddingBottom: 3,
                              paddingLeft: 30,
                              paddingRight: 10,
                              paddingTop: 5,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: counter >= size - 1
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: GeneralButtonContainer(
                                  name: 'Preview',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () => onPreview(e, size),
                                  paddingBottom: 3,
                                  paddingLeft: 30,
                                  paddingRight: 30,
                                  paddingTop: 5,
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: GeneralButtonContainer(
                                  name: 'Next',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () => executeOnNext(e, size),
                                  paddingBottom: 3,
                                  paddingLeft: 10,
                                  paddingRight: 30,
                                  paddingTop: 5,
                                ),
                              ),
                      ),
                    ],
                  ),
                ]),
          )),
    );
  }

  void executeOnNext(ObjInterviewQuestion e, int size) {
    Map<String?, dynamic> answer = context.read<EmpController>().objAnswers;
    if (counter < size - 1) {
      if (answer.containsKey(e.questionUid)) {
        setState(() {
          counter = counter + 1;
        });
      } else if (e.sub_answer.isNotEmpty) {
        context.read<EmpController>().addAnswers(e, e.sub_answer);
        saveBackground(this.duration);
        setState(() {
          counter = counter + 1;
        });
      } else {
        CustomSnack('Error', 'Select an answer!!.');
      }
    } else if (counter >= size - 2) {
      onPreview(e, size);
    }
  }

  void onPreview(ObjInterviewQuestion e, int size) async {
    Map answer = context.read<EmpController>().objAnswers;
    if (answer.containsKey(e.questionUid)) {
      Get.to(() => InterviewPreview(
            context.read<EmpController>().objAnswers,
            oModel: widget.oModel,
          ));
    } else if (e.sub_answer != '') {
      print(e.sub_answer);
      context.read<EmpController>().addAnswers(e, e.sub_answer);
      saveBackground(this.duration);
      Get.to(() => InterviewPreview(answer, oModel: widget.oModel));
    } else {
      CustomSnack('Error', 'Select an answer!!.');
    }
  }

  var _style = GoogleFonts.montserrat(fontSize: 14, color: Colors.black);

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
      _connectionStatus = result;
      if(_connectionStatus == ConnectivityResult.none){
        saveBackground(duration);
        Get.back();
        CustomSnack('Error', 'No Internet connection.....');
      }
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
