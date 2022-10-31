import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

class RedesignLanguage extends StatefulWidget {
  final bool isEdit;
  final Language? eModel;
  const RedesignLanguage({super.key, required this.isEdit, this.eModel});

  @override
  State<RedesignLanguage> createState() => _RedesignLanguageState();
}

class _RedesignLanguageState extends State<RedesignLanguage> {
  final language = TextEditingController();
  String proficiency = 'Language Proficiency';

  bool isLoading = false;
  bool isUpdate = false;
  bool isDelete = false;

  @override
  void initState() {
    if (widget.isEdit) {
      language.text = widget.eModel!.language!;
      proficiency = widget.eModel!.level!;
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
                  Text('Add Language',
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
                    getCardForm('select Language', 'Language', ctl: language),
                    const SizedBox(
                      height: 12.0,
                    ),
                    inputDropDown(
                        ['Fluent', 'Native', 'Beginner', 'Conversational'],
                        text: 'Language Proficiency',
                        hint: '$proficiency',
                        callBack: (s) => proficiency = s),
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
                                )))
                            : GestureDetector(
                                onTap: () => addLanguage({
                                  'language': language.text.toLowerCase(),
                                  'level': proficiency.toLowerCase()
                                }),
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
                              )
                        : Column(
                            children: [
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
                                          : () => updateData({
                                                'language': language.text.toLowerCase(),
                                                'level': proficiency.toLowerCase()
                                              }),
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
                                              'Update Language',
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
                                    : () => delete(widget.eModel!.id),
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
                            ],
                          ),
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

  void addLanguage(data) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await Dio().post('${ROOT}add/',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Language Added...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update language');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void delete(id) async {
    setState(() {
      isDelete = true;
    });
    try {
      final res = await Dio().delete(
          '${ROOT}languagedetails/${widget.eModel!.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Language Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update language');
    } finally {
      setState(() {
        isDelete = false;
      });
    }
  }

  void updateData(Map data) async {
    setState(() {
      isUpdate = true;
    });
    try {
      final res = await Dio().post(
          '${ROOT}languagedetails/${widget.eModel!.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Language Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update language');
    } finally {
      setState(() {
        isUpdate = false;
      });
    }
  }

  Widget inputDropDown(List<String> list,
      {text = 'Select certificate', hint = 'Certificate', callBack}) {
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
}
