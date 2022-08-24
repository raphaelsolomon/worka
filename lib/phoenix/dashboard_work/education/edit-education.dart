import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';
import '../Success.dart';

class EditEducation extends StatefulWidget {
  final Education eModel;
  EditEducation(this.eModel, {Key? key}) : super(key: key);

  @override
  _EditEducationState createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  final school_name = TextEditingController();
  final course = TextEditingController();
  String level = '';
  String certificate = '';
  String stringStop = '';
  String stringStart = '';
  bool isLoading = false;
  bool isDelete = false;
  bool isUpdate = false;

  @override
  void initState() {
    school_name.text = widget.eModel.schoolName!;
    course.text = widget.eModel.course!;
    level = widget.eModel.level!;
    certificate = widget.eModel.certificate!;
    stringStart = DateFormat('yyyy-MM-dd').format(widget.eModel.startDate);
    stringStop = DateFormat('yyyy-MM-dd').format(widget.eModel.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Education',
                    style: GoogleFonts.lato(
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
                  school_name, '', 'School name', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              CustomDropDown(LEVELS, callBack: (s) {
                level = s;
              }, hint: '$level', name: 'Level'),
              SizedBox(
                height: 10.0,
              ),
              CustomDropDown(CERTIFICATE, callBack: (s) {
                certificate = s;
              }, hint: '$certificate', name: 'Certificate'),
              SizedBox(
                height: 10.0,
              ),
              CustomTextForm(course, '', 'Course', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: 'yyyy-MM-dd',
                            initialValue: stringStart,
                            firstDate: DateTime(1770),
                            lastDate: DateTime(4100),
                            dateLabelText: 'Start Date',
                            onChanged: (val) {
                              setState(() {
                                stringStart = val;
                              });
                            },
                          ),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'yyyy-MM-dd',
                              initialValue: stringStop,
                              firstDate: DateTime(1770),
                              lastDate: DateTime(4100),
                              dateLabelText: 'End Date',
                              onChanged: (val) {
                                setState(() {
                                  stringStop = val;
                                });
                              }),
                        )),
                      ])),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isDelete
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GeneralButtonContainer(
                                  name: 'Update',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () {
                                    setState(() {
                                      isLoading = true;
                                      isUpdate = true;
                                    });
                                    var data = {
                                      'school_name': school_name.text,
                                      'course': course.text.toLowerCase(),
                                      'certificate': certificate.toLowerCase(),
                                      'level': level.toLowerCase(),
                                      'start_date': stringStart,
                                      'end_date': stringStop
                                    };
                                    executeData(data);
                                  },
                                  paddingBottom: 3,
                                  paddingLeft: 30,
                                  paddingRight: 30,
                                  paddingTop: 5,
                                ),
                        )),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isUpdate
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GeneralButtonContainer(
                                  name: 'Delete',
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPress: () {
                                    setState(() {
                                      isLoading = true;
                                      isDelete = true;
                                    });
                                    deleteItem(widget.eModel.id);
                                  },
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
        ),
      ),
    ));
  }

  void deleteItem(id) async {
    try {
      final res = await Dio().delete(
          '${ROOT}educationdetails/${widget.eModel.id}',
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
      CustomSnack('Error', 'Unable to update laguage');
    } finally {
      setState(() {
        isLoading = false;
        isDelete = false;
      });
      context.read<Controller>().getprofileReview();
    }
  }

  void executeData(Map data) async {
    try {
      final res = await Dio().post(
          '${ROOT}educationdetails/${widget.eModel.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Education Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update laguage');
    } finally {
      setState(() {
        isLoading = false;
        isUpdate = false;
      });
      context.read<Controller>().getprofileReview();
    }
  }
}
