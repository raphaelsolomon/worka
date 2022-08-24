import 'dart:convert';
import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/phoenix/screens/successPage.dart';
import 'package:worka/models/Createdinterview.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:http/http.dart' as http;
import 'package:worka/phoenix/model/Constant.dart';

class CreateInterview extends StatefulWidget {
  final String jobId;
  CreateInterview(this.jobId, {Key? key}) : super(key: key);

  @override
  State<CreateInterview> createState() => _CreateInterviewState();
}

class _CreateInterviewState extends State<CreateInterview> {
  final title = TextEditingController();
  final instruction = TextEditingController();
  bool isTimer = false;
  String type = '';
  bool isLoading = false;
  String timer = '30';
  var stringStart = '';
  var stringStop = '';
  List<int> number = [5, 10, 20, 30, 60, 120];

  @override
  void dispose() {
    title.dispose();
    instruction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Create Interview',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Color(0xff0D30D9),
                    onPressed: () {},
                  ),
                ),
              ]),
              SizedBox(height: 30.0),
              Text('Filling in the required data to create interview',
                  style: GoogleFonts.montserrat(
                      fontSize: 16.5, color: Colors.grey),
                  textAlign: TextAlign.center),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Title: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      CustomTextForm(
                          title, 'Enter title', 'title', TextInputType.text,
                          horizontal: 10.0),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Instruction:',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      CustomRichTextForm(
                          instruction,
                          'Please answer the question below',
                          'Note',
                          TextInputType.multiline,
                          null,
                          onChange: null,
                          onSaved: null,
                          horizontal: 10.0),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Interview type:',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      buildPaddingDropdown(['Theory', 'Objective'], 'Type',
                          callBack: (s) {
                        setState(() {
                          type = s;
                        });
                      }),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Checkbox(
                              value: isTimer,
                              onChanged: (b) {
                                setState(() {
                                  isTimer = b!;
                                });
                              }),
                          Flexible(
                              child: Text('Timer',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14, color: Colors.black54))),
                          Flexible(
                              fit: FlexFit.tight,
                              child: isTimer
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomNumberPicker(
                                        initialValue: 10,
                                        customAddButton: Container(
                                            margin: const EdgeInsets.only(
                                                left: 20.0),
                                            padding: const EdgeInsets.all(7.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.0),
                                                color: DEFAULT_COLOR),
                                            child: Icon(Icons.add,
                                                color: Colors.white)),
                                        customMinusButton: Container(
                                            padding: const EdgeInsets.all(7.0),
                                            margin: const EdgeInsets.only(
                                                right: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.0),
                                                color: DEFAULT_COLOR),
                                            child: Icon(Icons.remove,
                                                color: Colors.white)),
                                        maxValue: 60,
                                        minValue: 10,
                                        step: 5,
                                        onValue: (value) {
                                          setState(() {
                                            timer = '$value';
                                          });
                                        },
                                      ),
                                    )
                                  : Container())
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(),
                            child: DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Start Date',
                              onChanged: (val) => setState(() {
                                stringStart = val;
                              }),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'End Date',
                              onChanged: (val) => setState(() {
                                stringStop = val;
                              }),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GeneralButtonContainer(
                                name: 'Create Interview',
                                color: Color(0xff0D30D9),
                                textColor: Colors.white,
                                onPress: () => validate(context),
                                paddingBottom: 3,
                                paddingLeft: 10,
                                paddingRight: 10,
                                paddingTop: 5,
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  void validate(BuildContext context) async {
    if (title.text.trim().isEmpty) {
      CustomSnack('Error', 'Interview name is required');
      return;
    }
    if (instruction.text.trim().isEmpty) {
      CustomSnack('Error', 'Interview instruction is required');
      return;
    }

    if (type.isEmpty) {
      CustomSnack('Error', 'Please select interview type');
      return;
    }

    if (stringStart.isEmpty) {
      CustomSnack('Error', 'Please select interview start date');
      return;
    }

    if (stringStop.isEmpty) {
      CustomSnack('Error', 'Please select interview End date');
      return;
    }

    if (isTimer && timer.isEmpty) {
      CustomSnack('Error', 'Please select timer in minutes');
      return;
    }

    setState(() {
      isLoading = true;
    });

    var data = {
      'title': title.text.trim(),
      'note': instruction.text.trim(),
      'start_date': '$stringStart',
      'end_date': '$stringStop',
      'interview_type': type.toLowerCase(),
      'timer': '$isTimer',
      'timer_sec': '$timer'
    };

    createInterview(context, widget.jobId, data);
  }

  createInterview(BuildContext c, id, Map<String, Object> data) async {
    print(data);
    setState(() {
      isLoading = true;
    });
    try {
      final res = await http.Client().post(
          Uri.parse('${ROOT}interview/create_interview/$id'),
          headers: {
            'Accept': '*/*',
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          },
          body: data);
      if (res.statusCode == 200) {
        final result = Createdinterview.fromMap(jsonDecode(res.body));
        Get.off(() =>
            InterviewSuccessPage('Interview created successfully', result));
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection ....');
    } on Exception {
      CustomSnack('Error', 'unable to create interview, please try again');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Padding buildPaddingDropdown(List<String> data, String data1, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: FormBuilderDropdown(
              name: 'skill',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                labelText: data1,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              // initialValue: 'Male',
              //hint: Text(data1),
              onChanged: (s) => callBack(s),
              items: data
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
