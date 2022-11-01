import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
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

class Redesigncertification extends StatefulWidget {
  final bool isEdit;
  final Certificate? eModel;
  const Redesigncertification({super.key, required this.isEdit, this.eModel});

  @override
  State<Redesigncertification> createState() => _RedesigncertificationState();
}

class _RedesigncertificationState extends State<Redesigncertification> {
  final title = TextEditingController();
  final issuer = TextEditingController();
  var stringStart = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  final ceritificateID = TextEditingController();
  final ceritificateURL = TextEditingController();

  bool isLoading = false;
  bool isUpdate = false;
  bool isDelete = false;
  bool isChecked = false;

  @override
  void initState() {
    if (widget.isEdit) {
      title.text = widget.eModel!.title!;
      issuer.text = widget.eModel!.issuer!;
      ceritificateID.text = widget.eModel!.cid!;
      ceritificateURL.text = widget.eModel!.url!;
      stringStart = widget.eModel!.dated!;
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
                  Text('Certification',
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
                    getCardForm('Title', 'Title', ctl: title),
                    const SizedBox(
                      height: 10.0,
                    ),
                    getCardForm('Issuer', 'Issuer', ctl: issuer),
                    const SizedBox(
                      height: 10.0,
                    ),
                    getCardDateForm('Issuer Date', datetext: stringStart),
                    // const SizedBox(
                    //   height: 5.0,
                    // ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Checkbox(
                    //         onChanged: (b) {
                    //           context.read<Controller>().setWillExpire(b);
                    //         },
                    //         value: context.watch<Controller>().willExpire,
                    //         activeColor: DEFAULT_COLOR,
                    //       ),
                    //       Text(
                    //         'This will not expire',
                    //         style: GoogleFonts.lato(
                    //             fontSize: 12.0, color: Colors.black38),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    getCardForm('Certificate ID', 'Certificate ID',
                        ctl: ceritificateID),
                    const SizedBox(
                      height: 10.0,
                    ),
                    getCardForm('Certificate URL', 'Certificate URL',
                        ctl: ceritificateURL),
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
                                onTap: () => addCertification(),
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
                                          : () async {
                                              var data = {
                                                'cid': ceritificateID.text,
                                                'title': title.text,
                                                'issuer': issuer.text,
                                                'dated': stringStart,
                                                'url':
                                                    ceritificateURL.text.trim(),
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
                                              'Update Certification',
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

  addCertification() async {
    if (ceritificateID.text.trim().isEmpty) {
      CustomSnack('Error', 'Certificate ID is required...');
      return;
    }

    if (title.text.trim().isEmpty) {
      CustomSnack('Error', 'Title is required...');
      return;
    }

    if (issuer.text.trim().isEmpty) {
      CustomSnack('Error', 'Title is required...');
      return;
    }

    var data = {
      'cid': ceritificateID.text,
      'title': title.text,
      'issuer': issuer.text,
      'dated': stringStart,
      'url': ceritificateURL.text.trim(),
    };
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.Client().post(
        Uri.parse('${ROOT}addcertificate/'),
        body: data,
        headers: {'Authorization': 'TOKEN ${context.read<Controller>().token}'},
      );
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Ceritification added...',
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

  void delete(id) async {
    setState(() {
      isDelete = true;
    });
    try {
      final res = await Dio().delete(
          '${ROOT}certificatedetails/${widget.eModel!.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Certification Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to delete certificate');
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
          '${ROOT}certificatedetails/${widget.eModel!.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Certification Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update certificate');
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
