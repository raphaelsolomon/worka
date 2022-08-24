import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../controller/empContoller.dart';

class PreviewObj extends StatefulWidget {
  final String uid;
  PreviewObj(this.uid, {Key? key}) : super(key: key);

  @override
  State<PreviewObj> createState() => _PreviewObjState();
}

class _PreviewObjState extends State<PreviewObj> {
  bool isLoading = false;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text(
                  'Preview',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: Color(0xff0D30D9)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                )
              ]),
              SizedBox(height: 30.0),
              Text(
                'Proof read your interview questions before posting',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              //end of app bar design

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //the guides
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              ...context
                                  .watch<EmpController>()
                                  .objQuestion
                                  .entries
                                  .map((e) => Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Question:  ',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    Text(
                                                      '${e.value.keys.first}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 15,
                                                              height: 1.5,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'Options',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height: 3.0,
                                                    ),
                                                    ...List.generate(
                                                        4,
                                                        (i) => Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0,
                                                                  vertical:
                                                                      5.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0,
                                                                        right:
                                                                            10.0),
                                                                    child: Icon(
                                                                        Icons
                                                                            .panorama_fisheye_outlined,
                                                                        color: Color(
                                                                            0xff0D30D9),
                                                                        size:
                                                                            6),
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      '${e.value.values.first[i].capitalizeFirst}',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black38,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'Answer',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height: 3.0,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2.0,
                                                                    right:
                                                                        10.0),
                                                            child: Icon(Icons.panorama_fisheye_outlined,
                                                                color: Color(
                                                                    0xff0D30D9),
                                                                size: 6),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              '${e.value.values.first[4].capitalizeFirst}',
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<EmpController>()
                                                        .removeQuestionItem(
                                                            e.key);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    size: 17,
                                                    color: DEFAULT_COLOR,
                                                  ))
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GeneralButtonContainer(
                            name: 'Upload Question',
                            color: Color(0xff0D30D9),
                            textColor: Colors.white,
                            onPress: () => uploadObjQuestion(context),
                            paddingBottom: 3,
                            paddingLeft: 10,
                            paddingRight: 10,
                            paddingTop: 5,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ));
  }

  void uploadObjQuestion(BuildContext context) {
    setState(() {
      isLoading = true;
    });

    context.read<EmpController>().objQuestion.forEach((key, value) async {
      await submit(context, value.keys.first, value.values.first);
      counter = counter + 1;
      if (counter == context.read<EmpController>().objQuestion.length) {
        setState(() {
          isLoading = false;
        });
        CustomSnack('Success', 'Uploaded....');
        context.read<EmpController>().clearObjInterview();
        Get.offAll(() => EmployerNav());
      }
    });
  }

  submit(BuildContext c, question, List<String> answer) async {
    try {
      final res = await Dio().post(
          '${ROOT}interview/add_obj_question/${widget.uid}',
          data: {
            'question': '$question',
            'options': '${answer[0]}, ${answer[1]}, ${answer[2]}, ${answer[3]}',
            'answer': '${answer[4]}'.toLowerCase(),
          },
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        print('i am darkseid');
        return 'success';
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return 'error';
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return 'error';
    }
  }
}
