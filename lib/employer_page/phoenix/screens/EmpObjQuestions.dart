import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/phoenix/screens/addOptions.dart';
import 'package:worka/employer_page/phoenix/screens/previewObj.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/model/Constant.dart';

class EmpObjQuestions extends StatefulWidget {
  final String jobId;
  EmpObjQuestions(this.jobId, {Key? key}) : super(key: key);

  @override
  State<EmpObjQuestions> createState() => _EmpObjQuestionsState();
}

class _EmpObjQuestionsState extends State<EmpObjQuestions> {
  final controller = TextEditingController();

  int counter = 0;
  //Map<int, Map<String, List<String>>> objQuestion = {};

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<EmpController>().objQuestion;
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //custom app design
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
                        Text('Interview Questions',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, color: Color(0xff0D30D9)),
                            textAlign: TextAlign.center),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: watcher.isEmpty
                                ? Container()
                                : Stack(children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              watcher.length > 0 ? 15.0 : 0.0),
                                      child: TextButton(
                                          onPressed: () => preview(),
                                          child: Text('Preview',
                                              style: GoogleFonts.montserrat(
                                                  color: DEFAULT_COLOR))),
                                    ),
                                    watcher.length > 0
                                        ? Positioned(
                                            right: 0.0,
                                            top: 0.0,
                                            bottom: 0.0,
                                            child: CircleAvatar(
                                              child: Text('${watcher.length}',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 11)),
                                              radius: 10,
                                            ))
                                        : Container()
                                  ]))
                      ]),
                  SizedBox(height: 30.0),
                  //end of app bar design

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //the guides
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Enter Question Below:',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14, color: Color(0xff0D30D9)),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  CustomRichTextForm(
                                      controller,
                                      'Enter questions here',
                                      'Question',
                                      TextInputType.multiline,
                                      null,
                                      horizontal: 10.0)
                                ],
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () => validText(),
                                    child: Text('Add Options +',
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xff0D30D9))),
                                  )),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: GeneralButtonContainer(
                                name: 'Add Question',
                                color: Color(0xff0D30D9),
                                textColor: Colors.white,
                                onPress: () => validator(context),
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
                  )
                ],
              ),
            )));
  }

  void validText() {
    if (controller.text.trim().isNotEmpty) {
      Get.to(() => AddOptions());
    } else {
      CustomSnack('Error', 'Question field must not be empty');
    }
  }

  void preview() {
    if (context.read<EmpController>().objQuestion.isNotEmpty) {
      Get.to(() => PreviewObj(widget.jobId));
      return;
    }
    CustomSnack('Error', 'No Question Was Provided...');
  }

  void validator(BuildContext context) {
    if (context.read<EmpController>().optionsObj.isNotEmpty) {
      var option = [...context.read<EmpController>().optionsObj];
      context
          .read<EmpController>()
          .setQuestionItem(counter, controller.text.trim(), option);
      CustomSnack('Success', 'Question Added...');
      counter++;
      context.read<EmpController>().clearOptionObj();
      controller.clear();
      return;
    }
    CustomSnack('Error', 'Add Options for this question');
  }
}
