import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/InterviewObj.dart';
import 'package:worka/models/InterviewTheory.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/main_screens/main_nav.dart';
import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import '../Success.dart';

class InterviewPreview extends StatefulWidget {
  final Map answer;
  final InterviewTheory? tModel;
  final InterviewObj? oModel;
  InterviewPreview(this.answer, {this.oModel, this.tModel, Key? key})
      : super(key: key);

  @override
  State<InterviewPreview> createState() => _InterviewPreviewState();
}

class _InterviewPreviewState extends State<InterviewPreview> {
  int counter = 1;
  bool isLoading = false;
  Map<String, Map> display = {};

  @override
  void initState() {
    extractItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
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
                          onPressed: () {
                            Get.back();
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
                                                    Icons
                                                        .panorama_fish_eye_outlined,
                                                    color: DEFAULT_COLOR
                                                        .withOpacity(.3),
                                                    size: 6.0,
                                                  ),
                                                  SizedBox(width: 6.0),
                                                  Text(
                                                    '${e.value['answer']}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 13.5,
                                                            color:
                                                                Colors.black54),
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
                                        widget.oModel == null
                                            ? executeTheory(widget.answer,
                                                widget.tModel!.interviewUid)
                                            : executeObj(widget.answer,
                                                widget.oModel!.interviewUid);
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
            ),
          ),
        ));
  }

  void executeTheory(Map data, id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await Dio().post('${ROOT}interview/submit_theory_answer/$id',
          data: {'answers': jsonEncode(data)},
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Interview submitted...',
              imageAsset: 'assets/post_success.png',
              callBack: () => Get.offAll(() => MainNav()),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to submit interview');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void executeObj(Map data, id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await Dio().post('${ROOT}interview/submit_obj_answer/$id',
          data: {'answers': jsonEncode(data)},
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Interview submitted...',
              imageAsset: 'assets/post_success.png',
              callBack: () => Get.offAll(() => MainNav()),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to submit interview');
    } finally {
      context.read<EmpController>().clearObj();
      setState(() {
        isLoading = false;
      });
    }
  }

  void extractItems() {
    if (widget.oModel != null) {
      widget.answer.forEach((key, value) {
        display.putIfAbsent(
            key,
            () => {
                  'question':
                      '${widget.oModel!.objInterviewQuestion!.firstWhere((element) => element.questionUid == key).question}',
                  'answer': '$value'
                });
      });
    } else if (widget.tModel != null) {
      widget.answer.forEach((key, value) {
        display.putIfAbsent(
            key,
            () => {
                  'question':
                      '${widget.tModel!.theoryInterviewQuestion!.firstWhere((element) => element.questionUid == key).question}',
                  'answer': '$value'
                });
      });
    }
  }
}
