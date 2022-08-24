import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:http/http.dart' as http;

class TheoryQuestion extends StatefulWidget {
  final String jobId;
  const TheoryQuestion(this.jobId, {Key? key}) : super(key: key);

  @override
  State<TheoryQuestion> createState() => _TheoryQuestionState();
}

class _TheoryQuestionState extends State<TheoryQuestion> {
  List<String> complete = [];
  bool isLoading = false;
  final controller = TextEditingController();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //custom app design
                SizedBox(height: 5.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Questions',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, color: Color(0xff0D30D9)),
                            textAlign: TextAlign.center),
                      ),
                      complete.isEmpty
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: isLoading
                                  ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        addInterviewTheory(
                                            context, widget.jobId, complete);
                                      },
                                      child: Text('Submit',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              color: DEFAULT_COLOR),
                                          textAlign: TextAlign.center),
                                    ))
                    ]),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'All Questions',
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                ),
                //end of app bar design

                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.0),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                itemBuilder: (ctx, i) => itemList(complete, i),
                                itemCount: complete.length),
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        //the guides
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Enter your question below:',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, color: Color(0xff0D30D9)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              textField()
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30.0,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: isLoading
                              ? Container()
                              : GeneralButtonContainer(
                                  name: 'Add Question',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () {
                                    if (controller.text.trim().isNotEmpty) {
                                      setState(() {
                                        complete.add(controller.text.trim());
                                        controller.clear();
                                      });
                                    }
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
                )
              ],
            ),
          ),
        ));
  }

  void addInterviewTheory(BuildContext c, id, List<String> question) {
    question.forEach((s) async {
      try {
        final res = await http.Client().post(
            Uri.parse(
                '${ROOT}interview/add_theory_question/${id}'),
            body: {
              'question': s,
            },
            headers: {
              'Authorization': 'TOKEN ${c.read<Controller>().token}'
            });
        if (res.statusCode == 200) {
          counter = counter + 1;
          if (counter == question.length) {
            setState(() {
              isLoading = false;
            });
            CustomSnack('Success', 'Uploaded....');
            Get.offAll(() => EmployerNav());
          }
          return;
        }
      } on SocketException {
        CustomSnack('Error', 'Check Internet Connection..');
        counter = counter + 1;
      } on Exception {
        CustomSnack('Error', 'Could not submit job. Please try again');
        counter = counter + 1;
      }
    });
  }

  Widget textField() => Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      margin: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        style: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Questions',
          labelText: 'Questions',
          labelStyle: GoogleFonts.montserrat(
            fontSize: 15.0,
            color: Colors.black,
          ),
          hintStyle: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 9.9, vertical: 9.9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
          ),
        ),
        keyboardType: TextInputType.text,
      ));

  Widget itemList(List<String> e, i) => Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                'Question ${i + 1} : ${e[i]}',
                style:
                    GoogleFonts.montserrat(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.start,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    e.removeAt(i);
                  });
                },
                icon: Icon(Icons.cancel, size: 17, color: DEFAULT_COLOR))
          ],
        ),
      );
}
