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
import 'package:worka/models/InterviewTheory.dart';
import 'package:worka/phoenix/countDown.dart';
import '../../../screens/main_screens/main_nav.dart';
import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';
import '../../model/Constant.dart';
import '../Success.dart';
import 'interviewPreview.dart';

class TheoryInterview extends StatefulWidget {
  final InterviewTheory tModel;
  final Duration timer;
  final Map answer;
  TheoryInterview(this.tModel, this.timer, this.answer);
  @override
  State<TheoryInterview> createState() => _TheoryInterviewState();
}

class _TheoryInterviewState extends State<TheoryInterview> {
  final controller = TextEditingController();
  final pageCtl = PageController();
  int counter = 0;
  bool iscompleted = false;
  var savedValue = [];
  bool isPreview = false;
  bool isLoading = false;
  var _item = [];
  Duration duration = Duration(hours: 0, minutes: 0, microseconds: 400);
  Map<String, Map> display = {};
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    counter = (widget.answer.isEmpty ? 0 : widget.answer.length - 1);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  Future<Map> checkIfExist() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(widget.tModel.interviewUid!)) {
      String data = pref.getString(widget.tModel.interviewUid!) ?? '';
      Map<String, dynamic> encoded = jsonDecode(data);
      return encoded['answer'];
    }
    return {};
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    controller.dispose();
    pageCtl.dispose();
    super.dispose();
  }

  Future<bool> onBackPress() async {
    if (isPreview) {
      setState(() {
        isPreview = false;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _item = widget.tModel.theoryInterviewQuestion!;
    extractItems();
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: SafeArea(
            child: isPreview ? _previewPage() : _questionPage(context, _item)),
      ),
    );
  }

  void executeTheory(Map data, id) async {
    setState(() {
      iscompleted = true;
    });
    try {
      final res = await Dio().post('${ROOT}interview/submit_theory_answer/$id',
          data: {'answers': jsonEncode(data)},
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'interview submited...');
        Get.off(() => Success(
              'interview submited...',
              imageAsset: 'assets/post_success.png',
              callBack: () => Get.offAll(() => MainNav()),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to submit interview');
    }
  }

  void saveItem(List<TheoryInterviewQuestion> data, String s) {
    if (widget.answer[data[counter].questionUid] != null) {
      widget.answer[data[counter].questionUid] = s;
      return;
    }
    widget.answer.putIfAbsent(data[counter].questionUid, () => s);
    saveBackground(this.duration);
  }

  void onBack(List<TheoryInterviewQuestion> data) {
    if (counter > 0) {
      setState(() {
        counter = counter - 1;
        controller.text = widget.answer[data[counter].questionUid];
      });
      pageCtl.previousPage(
          duration: Duration(microseconds: 1), curve: Curves.linear);
    }
  }

  void onNextItem(List<TheoryInterviewQuestion> data) async {
    print(widget.answer);
    if ((counter + 1) < (data.length)) {
      if (controller.text.trim().isEmpty &&
          widget.answer[data[counter].questionUid] == null) {
        CustomSnack('Error', 'All Question Must Be Answered');
      } else {
        saveItem(data, controller.text);
        setState(() {
          this.controller.clear();
          counter = counter + 1;
          if (widget.answer[data[counter].questionUid] != null) {
            controller.text = widget.answer[data[counter].questionUid];
          }
        });
        pageCtl.nextPage(
            duration: Duration(microseconds: 1), curve: Curves.linear);
      }
    } else if ((counter + 1) == (data.length)) {
      saveItem(data, controller.text);
      setState(() {
        isPreview = true;
      });
    }
  }

  void saveBackground(Duration remaining) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.tModel.interviewUid!)) {
      prefs.remove(widget.tModel.interviewUid!);
    }
    Map<String, dynamic> _mapString = {
      'timer': remaining.toString(),
      'answer': widget.answer
    };
    prefs.setString(widget.tModel.interviewUid!, jsonEncode(_mapString));
  }

  Widget _questionPage(BuildContext context, _item) => Column(
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
                child: Text('${counter + 1} of ${_item.length}',
                    style: GoogleFonts.montserrat(
                        fontSize: 13, color: Colors.black26),
                    textAlign: TextAlign.center))
          ]),
          SizedBox(height: 15.0),
          //end of app bar design
          widget.tModel.timer == true
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
                          duration: widget.timer,
                          onFinish: () {
                            executeTheory(
                                widget.answer, widget.tModel.interviewUid);
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
          SizedBox(height: 15.0),
          Expanded(
            child: SingleChildScrollView(
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
                                  fontSize: 14, color: Colors.black45),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              '${_item[counter].question}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 17, color: Colors.black87),
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
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Answer:',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 510,
                            child: PageView(
                              controller: pageCtl,
                              physics: NeverScrollableScrollPhysics(),
                              pageSnapping: true,
                              children: widget.tModel.theoryInterviewQuestion!
                                  .map((e) => CustomRichTextForm(
                                      controller,
                                      widget.answer[_item[counter].questionUid],
                                      'Type your answer here',
                                      TextInputType.multiline,
                                      28,
                                      color: widget.answer[
                                                  _item[counter].questionUid] !=
                                              null
                                          ? Colors.grey.shade100
                                          : Colors.white,
                                      read: widget.answer[
                                              _item[counter].questionUid] !=
                                          null,
                                      onChange: (s) => null))
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    iscompleted
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: counter >= (_item.length)
                                ? GeneralButtonContainer(
                                    name: 'Preview',
                                    color: Color(0xff0D30D9),
                                    textColor: Colors.white,
                                    onPress: () {
                                      Get.to(() => InterviewPreview(
                                          widget.answer,
                                          tModel: widget.tModel));
                                    },
                                    paddingBottom: 3,
                                    paddingLeft: 30,
                                    paddingRight: 30,
                                    paddingTop: 5,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: counter == 0
                                            ? null
                                            : () => onBack(_item),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: counter == 0
                                                  ? Colors.grey.withOpacity(.2)
                                                  : Color(0xff0D30D9),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Center(
                                                child: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: counter == 0
                                                        ? Colors.grey
                                                        : Colors.white)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      GestureDetector(
                                        onTap: () => onNextItem(_item),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xff0D30D9),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Center(
                                                child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ]),
            ),
          )
        ],
      );

  Widget _previewPage() => Column(
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
                onPressed: () {
                  setState(() {
                    isPreview = false;
                  });
                },
              ),
            ),
            Text('Preview',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(null),
                color: Colors.transparent,
                onPressed: null,
              ),
            ),
          ]),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      //the guides
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.03),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: DEFAULT_COLOR.withOpacity(.05),
                                width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              ...display.entries.map(
                                (e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                            'Question:  ${e.value['question']}',
                                            minFontSize: 10,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                color: Colors.black87)),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.panorama_fish_eye_outlined,
                                              color:
                                                  DEFAULT_COLOR.withOpacity(.3),
                                              size: 6.0,
                                            ),
                                            SizedBox(width: 6.0),
                                            Text(
                                              '${e.value['answer']}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13.5,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GeneralButtonContainer(
                                name: 'Submit',
                                color: Color(0xff0D30D9),
                                textColor: Colors.white,
                                onPress: () {
                                  executeTheory(widget.answer,
                                      widget.tModel.interviewUid);
                                },
                                paddingBottom: 3,
                                paddingLeft: 30,
                                paddingRight: 30,
                                paddingTop: 5,
                              ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ]),
              ),
            ),
          )
        ],
      );

  void extractItems() {
    widget.answer.forEach((key, value) {
      display.putIfAbsent(
          key,
          () => {
                'question':
                    '${widget.tModel.theoryInterviewQuestion!.firstWhere((element) => element.questionUid == key).question}',
                'answer': '$value'
              });
    });
  }

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
