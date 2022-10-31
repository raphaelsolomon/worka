import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

class ProfessionalSummary extends StatefulWidget {
  final String data;
  final ProfileModel profileModel;
  const ProfessionalSummary(this.data, this.profileModel, {super.key});

  @override
  State<ProfessionalSummary> createState() => _ProfessionalSummaryState();
}

class _ProfessionalSummaryState extends State<ProfessionalSummary> {
  final controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    if(widget.data.trim().isNotEmpty){
      controller.text = widget.data;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Text('Professional Summary',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maximum of (300 characters)',
                    style: GoogleFonts.lato(
                        fontSize: 13.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputWidgetRich(
                      hint:
                          'Let your Employer know about you and your experience',
                      ctl: controller),
                  const SizedBox(
                    height: 30.0,
                  ),
                  isLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: DEFAULT_COLOR)))
                      : GestureDetector(
                          onTap: () async {
                            if (controller.text.trim().isEmpty) {
                              CustomSnack('Error', 'Required field is empty');
                              return;
                            }
                            executeThis();
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

  void executeThis() async {
    setState(() {
        isLoading = true;
      });
      var profile = widget.profileModel;
      profile.profileSummary = controller.text;
    try {
      final res = await Dio().post('${ROOT}employeedetails/',
         data: {
            'resume_headline': widget.profileModel.resumeHeadline,
            'uid': widget.profileModel.uid.toString(),
            'first_name': widget.profileModel.firstName,
            'last_name': widget.profileModel.lastName,
            'other_name': widget.profileModel.otherName,
            'gender': widget.profileModel.gender.toString(),
            'display_picture': widget.profileModel.displayPicture.toString(),
            'location': widget.profileModel.location,
            'about': widget.profileModel.about,
            'phone': widget.profileModel.phone,
            'profile_summary': controller.text.trim()
          },
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Professional Summary Added.',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
    } on Exception {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget inputWidgetRich({hint = 'Type here', ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.4,
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
    );
  }
}
