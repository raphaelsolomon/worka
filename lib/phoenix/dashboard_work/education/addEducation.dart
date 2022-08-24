import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controllers/constants.dart';
import '../../../controllers/loading_controller.dart';
import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';
import 'package:http/http.dart' as http;

import '../../model/Constant.dart';
import '../Success.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({Key? key}) : super(key: key);

  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final ctlName = TextEditingController();
  final ctlLevel = TextEditingController();
  final ctlCert = TextEditingController();
  final ctlCourse = TextEditingController();
  bool isLoading = false;
  var stringStart =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  var stringStop =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
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
                        Text('Education',
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
                  const SizedBox(height: 20.0),
                  imageView('${context.watch<Controller>().avatar}'),
                  const SizedBox(height: 30),
                  CustomTextForm(
                      ctlName, '', 'School name', TextInputType.text),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomDropDown(LEVELS,
                      callBack: (s) =>
                          context.read<LoadingController>().setLevel(s),
                      hint: 'Select level',
                      name: 'Level'),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomDropDown(CERTIFICATE,
                      callBack: (s) =>
                          context.read<LoadingController>().setCertificate(s),
                      hint: 'Select Certificate',
                      name: 'Certificate'),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomTextForm(ctlCourse, '', 'Course', TextInputType.text),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DateTimePicker(
                                    type: DateTimePickerType.date,
                                    dateMask: 'yyyy-MM-dd',
                                    initialValue: DateTime.now().toString(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Start Date',
                                    onChanged: (val) => stringStart = val,
                                  ),
                                )),
                            Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DateTimePicker(
                                    type: DateTimePickerType.date,
                                    dateMask: 'yyyy-MM-dd',
                                    initialValue: DateTime.now().toString(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'End Date',
                                    onChanged: (val) => stringStop = val,
                                  ),
                                )),
                          ])),
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GeneralButtonContainer(
                                name: 'Add Education',
                                color: Color(0xff0D30D9),
                                textColor: Colors.white,
                                onPress: () => addEducation(
                                    context,
                                    ctlName.text.trim(),
                                    stringStart,
                                    stringStop,
                                    ctlCourse.text.trim()),
                                paddingBottom: 3,
                                paddingLeft: 30,
                                paddingRight: 30,
                                paddingTop: 5,
                              ),
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            )));
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

    if ((end_date ==
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}') &&
        (start_date ==
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}')) {
      CustomSnack('Error', 'Both Date is can not be the same...');
      return;
    }

    if (DateTime.parse(end_date).millisecondsSinceEpoch <
        DateTime.parse(start_date).millisecondsSinceEpoch) {
      CustomSnack('Error', 'End Date must be greater than start Date...');
      return;
    }

    var data = {
      'school_name': '$school'.toLowerCase(),
      'level': '${c.read<LoadingController>().level}'.toLowerCase(),
      'certificate': '${c.read<LoadingController>().certificate}'.toLowerCase(),
      'start_date': '$start_date',
      'end_date': '$end_date',
      'course': '$course'.toLowerCase(),
    };
    print(data);
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.Client().post(
        Uri.parse('${ROOT}addeducation/'),
        body: data,
        headers: {'Authorization': 'TOKEN ${c.read<Controller>().token}'},
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
      context.read<Controller>().getprofileReview();
    }
  }
}
