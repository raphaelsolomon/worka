import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';
import '../../Resusable.dart';
import '../Success.dart';

class EditExperience extends StatefulWidget {
  final WorkExperience eModel;
  EditExperience(this.eModel);

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  bool isLoading = false;

  final title = TextEditingController();

  final company = TextEditingController();

  final desc = TextEditingController();

  final startDate = TextEditingController();

  bool isChecked = false;
  bool isDelete = false;
  bool isUpdate = false;

  var stringStart =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  var stringStop =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  @override
  void initState() {
    title.text = widget.eModel.title!;
    company.text = widget.eModel.companyName!;
    desc.text = widget.eModel.description!;
    isChecked = widget.eModel.current!;
    stringStart = DateFormat('yyyy-MM-dd').format(widget.eModel.startDate);
    stringStop = DateFormat('yyyy-MM-dd').format(widget.eModel.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    color: DEFAULT_COLOR,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text('Add Experience',
                    style: GoogleFonts.lato(fontSize: 18, color: DEFAULT_COLOR),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.black,
                    onPressed: null,
                  ),
                )
              ]),
              const SizedBox(height: 8.0),
              imageView('${context.watch<Controller>().avatar}', context),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Work Experience',
                    style: GoogleFonts.lato(
                        fontSize: 14.0,
                        color: DEFAULT_COLOR,
                        decoration: TextDecoration.none)),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomTextForm(
                  title, 'Software Engineer', 'job title', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              CustomTextForm(
                  company, 'Aptech Dev Center', 'company', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              CustomRichTextForm(
                  desc, null, 'Work Description', TextInputType.text, 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (b) {
                          setState(() {
                            isChecked = b!;
                          });
                        }),
                    Text(
                      'Current Working',
                      style: GoogleFonts.montserrat(
                          fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
              ),
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
                        dateMask: 'd MMM, yyyy',
                        initialValue: stringStart,
                        firstDate: widget.eModel.startDate,
                        lastDate: DateTime(2100),
                        dateLabelText: 'Start Date',
                        onChanged: (val) => setState(() {
                          stringStart = val;
                        }),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: stringStop,
                        firstDate: widget.eModel.endDate,
                        lastDate: DateTime(2100),
                        dateLabelText: 'End Date',
                        onChanged: (val) => setState(() {
                          stringStop = val;
                        }),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: isDelete
                        ? Container()
                        : isLoading
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
                                    'title': title.text,
                                    'company_name': company.text,
                                    'description': desc.text,
                                    'current': isChecked
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: isUpdate
                        ? Container()
                        : isLoading
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
                                  delete(widget.eModel.id);
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
    );
  }

  void delete(id) async {
    try {
      final res = await Dio().delete(
          '${ROOT}workexperiencedetails/${widget.eModel.id}',
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
          '${ROOT}workexperiencedetails/${widget.eModel.id}',
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
