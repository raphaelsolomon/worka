import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/controllers/loading_controller.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

class RedesignExperience extends StatefulWidget {
  final bool isEdit;
  final WorkExperience? eModel;
  const RedesignExperience({super.key, required this.isEdit, this.eModel});

  @override
  State<RedesignExperience> createState() => _RedesignExperienceState();
}

class _RedesignExperienceState extends State<RedesignExperience> {
  final organisationController = TextEditingController();
  final roleController = TextEditingController();
  final briefController = TextEditingController();

  bool isLoading = false;
  bool isUpdate = false;
  bool isDelete = false;

  bool isChecked = false;
  var stringStart = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  var stringStop = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  @override
  void initState() {
     if(widget.isEdit) {
      organisationController.text = widget.eModel!.companyName!;
      roleController.text = widget.eModel!.title!;
      briefController.text = widget.eModel!.description!;
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
                  Text('Work Experience',
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
              child: Column(
                children: [
                  getCardForm('Organization', 'Organization',
                      ctl: organisationController),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardForm('Job Role', 'Job Role', ctl: roleController),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(children: [
                    Flexible(
                      child:
                          getCardDateForm('Start Date', datetext: stringStart),
                    ),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: getCardDateForm('End Date', datetext: stringStop),
                    ),
                  ]),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputWidgetRich(ctl: briefController),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: (b) {
                                setState(() {
                                  isChecked = !b!;
                                });
                              },
                              value: isChecked,
                              activeColor: DEFAULT_COLOR,
                            ),
                            Text(
                              'Graduate',
                              style: GoogleFonts.lato(
                                  fontSize: 12.0, color: Colors.black38),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  context.watch<LoadingController>().isAddExperience
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            context.read<LoadingController>().addExperience(
                                organisationController.text.trim(),
                                roleController.text.trim(),
                                stringStart,
                                stringStop,
                                briefController.text.trim(),
                                context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: DEFAULT_COLOR),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.lato(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              )),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void delete(id) async {
     setState(() {
        isDelete = false;
      });
    try {
      final res = await Dio().delete(
          '${ROOT}workexperiencedetails/${widget.eModel!.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Experience Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to delete experience');
    } finally {
      setState(() {
        isDelete = false;
      });
    }
  }

  void executeData(Map data) async {
     setState(() {
        isUpdate = true;
      });
    try {
      final res = await Dio().post(
          '${ROOT}workexperiencedetails/${widget.eModel!.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Experience Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update experience');
    } finally {
      setState(() {
        isUpdate = false;
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
                    style:
                        GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                    decoration: InputDecoration(
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
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

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
