import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

class RedesignEducation extends StatefulWidget {
  final bool isEdit;
  final Education? eModel;
  const RedesignEducation({super.key, required this.isEdit, this.eModel});

  @override
  State<RedesignEducation> createState() => _RedesignEducationState();
}

class _RedesignEducationState extends State<RedesignEducation> {
  final schoolname = TextEditingController();
  final disciplineController = TextEditingController();
  final briefController = TextEditingController();
  String level = 'Level';
  String certificate = 'Award Institution';
  bool isChecked = false;
  bool isLoading = false;
  bool isUpdate = false;
  bool isDelete = false;
  var stringStart =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  var stringStop =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  @override
  void initState() {
    if (widget.isEdit) {
      schoolname.text = widget.eModel!.schoolName!;
      disciplineController.text = widget.eModel!.course!;
      briefController.text = '';
      level = widget.eModel!.level!;
      certificate = widget.eModel!.certificate!;
      stringStart = widget.eModel!.startDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Education',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getCardForm('School Name', 'School Name', ctl: schoolname),
                    const SizedBox(
                      height: 10.0,
                    ),
                    getCardForm('Discipline', 'Discipline',
                        ctl: disciplineController),
                    const SizedBox(
                      height: 10.0,
                    ),
                    inputDropDown(LEVELS,
                        text: 'Select Level',
                        hint: '$level',
                        callBack: (s) => level = s),
                    const SizedBox(
                      height: 10.0,
                    ),
                    inputDropDown(CERTIFICATE,
                        text: 'Award Institution',
                        hint: '$certificate',
                        callBack: (s) => certificate = s),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Flexible(
                        child: getCardDateForm('Start Date',
                            datetext: stringStart),
                      ),
                      const SizedBox(width: 20.0),
                      Flexible(
                        child:
                            getCardDateForm('End Date', datetext: stringStop),
                      ),
                    ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                    inputWidgetRich(ctl: briefController),
                    const SizedBox(
                      height: 30.0,
                    ),
                    widget.isEdit == false
                        ? isLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: DEFAULT_COLOR,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => addEducation(
                                    context,
                                    schoolname.text.trim(),
                                    stringStart,
                                    stringStop,
                                    disciplineController.text.trim()),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: DEFAULT_COLOR),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.lato(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    )),
                              )
                        : Column(children: [
                            isUpdate
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: DEFAULT_COLOR,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: isDelete
                                        ? () {}
                                        : () async {
                                            var data = {
                                              'school_name': schoolname.text.capitalize,
                                              'level': level.toLowerCase(),
                                              'certificate': certificate.toLowerCase(),
                                              'start_date': stringStart,
                                              'end_date': stringStop,
                                              'description': '${briefController.text}',
                                              'course': certificate.toLowerCase(),
                                            };
                                            updateData(data);
                                          },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(15.0),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: isDelete
                                                ? Colors.grey.shade300
                                                : DEFAULT_COLOR),
                                        child: Center(
                                          child: Text(
                                            'Update Education',
                                            style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: isDelete
                                                    ? Colors.black87
                                                    : Colors.white),
                                          ),
                                        ))),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: isUpdate
                                  ? () {}
                                  : () => deleteItem(widget.eModel!.id),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete,
                                      color: isUpdate
                                          ? Colors.black45
                                          : Colors.redAccent),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    'Delete',
                                    style: GoogleFonts.lato(
                                        fontSize: 17.0, color: Colors.black54),
                                  )
                                ],
                              ),
                            )
                          ]),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  addEducation(BuildContext c, school, start_date, end_date, course) async {
    if (school.isEmpty) {
      CustomSnack('Error', 'School Name is required...');
      return;
    }
    if (course.isEmpty) {
      CustomSnack('Error', 'Course is required...');
      return;
    }

    // if ((end_date ==
    //         '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}') &&
    //     (start_date ==
    //         '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}')) {
    //   CustomSnack('Error', 'Both Date is can not be the same...');
    //   return;
    // }

    // if (DateTime.parse(end_date).millisecondsSinceEpoch <
    //     DateTime.parse(start_date).millisecondsSinceEpoch) {
    //   CustomSnack('Error', 'End Date must be greater than start Date...');
    //   return;
    // }
    print(start_date);

    var data = {
      'school_name': '$school'.toLowerCase(),
      'level': level.toLowerCase(),
      'certificate': certificate.toLowerCase(),
      'start_date': '$start_date',
      'end_date': '$end_date',
      'description': '${briefController.text}',
      'course': '$course'.toLowerCase(),
    };
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.Client().post(
        Uri.parse('${ROOT}addeducation/'),
        body: data,
        headers: {'Authorization': 'TOKEN ${context.read<Controller>().token}'},
      );
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Education added...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateData(Map data) async {
    setState(() {
      isUpdate = true;
    });
    try {
      final res = await Dio().post(
          '${ROOT}educationdetails/${widget.eModel!.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Education Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update education');
    } finally {
      setState(() {
        isUpdate = false;
      });
    }
  }

  void deleteItem(id) async {
    setState(() {
      isDelete = true;
    });
    try {
      final res = await Dio().delete(
          '${ROOT}educationdetails/${widget.eModel!.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Education Delete...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to delete education');
    } finally {
      setState(() {
        isDelete = false;
      });
    }
  }

  getCardDateForm(label, {datetext}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: Row(
              children: [
                Flexible(
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    style: GoogleFonts.lato(fontSize: 13.5, color: Colors.black54),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (val) => datetext = val,
                  ),
                ),
                const SizedBox(width: 10.0),
                Icon(
                  Icons.timelapse,
                  color: Colors.black26,
                  size: 18.0,
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inputDropDown(List<String> list, {text = 'Select certificate', hint = 'Certificate', callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: FormBuilderDropdown(
              name: 'dropDown',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              // initialValue: 'Male',
              onChanged: (s) => callBack(s),
              hint: Text('$hint',
                  style:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
              items: list
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          '$s',
                          style: GoogleFonts.lato(
                              fontSize: 15.0, color: Colors.black54),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  Widget inputWidgetRich({hint = 'Type here', ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brief Description',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: MediaQuery.of(context).size.height / 6.5,
            decoration: BoxDecoration(
              color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              controller: ctl,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.black54),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                  hintText: '$hint',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }
}
