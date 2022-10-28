import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/JobDetails.dart';

class ApplySubmit extends StatelessWidget {
  final JobData job;
  ApplySubmit(this.job, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: DEFAULT_COLOR,
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Apply',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: DEFAULT_COLOR),
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
              SizedBox(height: 30.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Preview',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: DEFAULT_COLOR),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text('${job.title}',
                          style: GoogleFonts.montserrat(
                              fontSize: 19, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 2.0),
                      Text('Shell.com',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black26),
                          textAlign: TextAlign.start),
                    ],
                  )),
              SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          width: 1.0, color: Colors.blue.withOpacity(.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text(
                          '${context.watch<Controller>().profileModel!.firstName} ${context.watch<Controller>().profileModel!.lastName} ${context.watch<Controller>().profileModel!.otherName}',
                          style: GoogleFonts.montserrat(
                              fontSize: 12.5, color: SUB_HEAD),
                          textAlign: TextAlign.start),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Email Address',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text('${context.watch<Controller>().profileModel!.user!
                          .email}',
                          style: GoogleFonts.montserrat(
                              fontSize: 12.5, color: SUB_HEAD),
                          textAlign: TextAlign.start),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Gender',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text(
                          '${context.watch<Controller>().profileModel!.gender}',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: SUB_HEAD),
                          textAlign: TextAlign.start),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Location',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text(
                          '${context.watch<Controller>().profileModel!.location}',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: SUB_HEAD),
                          textAlign: TextAlign.start),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('About',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      Text('${context.watch<Controller>().profileModel!.about}',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: SUB_HEAD),
                          textAlign: TextAlign.start),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Skills',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 3.0),
                      context.watch<Controller>().profileModel!.skill!.isEmpty
                          ? Text('No Skills History',
                              style: GoogleFonts.montserrat(fontSize: 16))
                          : Column(
                              children: [
                                ...List.generate(
                                  context
                                      .watch<Controller>()
                                      .profileModel!
                                      .skill!
                                      .length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Skill name: ${context.watch<Controller>().profileModel!.skill![index].skillName}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          Text(
                                              'Level: ${context.watch<Controller>().profileModel!.skill![index].level}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          Text(
                                              'Years of exp: ${context.watch<Controller>().profileModel!.skill![index].yearOfExperience}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Work Experience',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      context
                              .watch<Controller>()
                              .profileModel!
                              .workExperience!
                              .isEmpty
                          ? Text('No Work Experience History',
                              style: GoogleFonts.montserrat(fontSize: 16))
                          : Column(
                              children: [
                                ...List.generate(
                                  context
                                      .watch<Controller>()
                                      .profileModel!
                                      .workExperience!
                                      .length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Title: ${context.watch<Controller>().profileModel!.workExperience![index].title}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          SizedBox(height: 2.0),
                                          Text(
                                              'Company name: ${context.watch<Controller>().profileModel!.workExperience![index].companyName}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          SizedBox(height: 2.0),
                                          Text(
                                              'from: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(context.watch<Controller>().profileModel!.workExperience![index].startDate!))}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          SizedBox(height: 2.0),
                                          SizedBox(height: 2.0),
                                          Text(
                                              'Currently: ${context.watch<Controller>().profileModel!.workExperience![index].current}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: SUB_HEAD),
                                              textAlign: TextAlign.start),
                                          SizedBox(height: 2.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Education',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      context
                              .watch<Controller>()
                              .profileModel!
                              .education!
                              .isEmpty
                          ? Text('No Education History',
                              style: GoogleFonts.montserrat(fontSize: 16))
                          : Column(
                              children: [
                                ...List.generate(
                                    context
                                        .watch<Controller>()
                                        .profileModel!
                                        .education!
                                        .length,
                                    (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 5.0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'School Name: ${context.watch<Controller>().profileModel!.education![index].schoolName}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'Level: ${context.watch<Controller>().profileModel!.education![index].level}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'Certificate: ${context.watch<Controller>().profileModel!.education![index].certificate}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'Course: ${context.watch<Controller>().profileModel!.education![index].course}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'Current: ${context.watch<Controller>().profileModel!.education![index].current}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'from: ${DateFormat('yyyy-MM-dd').format(DateTime.parse( context.watch<Controller>().profileModel!.education![index].startDate!))}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                ]))))
                              ],
                            ),
                      SizedBox(height: 15.0),
                      //========================================================
                      Text('Language',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start),
                      SizedBox(height: 5.0),
                      context
                              .watch<Controller>()
                              .profileModel!
                              .language!
                              .isEmpty
                          ? Text('No Language History',
                              style: GoogleFonts.montserrat(fontSize: 16))
                          : Column(
                              children: [
                                ...List.generate(
                                    context
                                        .watch<Controller>()
                                        .profileModel!
                                        .language!
                                        .length,
                                    (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 5.0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Language: ${context.watch<Controller>().profileModel!.language![index].language}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                  Text(
                                                      'Level: ${context.watch<Controller>().profileModel!.language![index].level}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: SUB_HEAD),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(height: 2.0),
                                                ]))))
                              ],
                            ),
                      SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: context.read<Controller>().isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GeneralButtonContainer(
                        name: 'Apply now',
                        color: DEFAULT_COLOR,
                        textColor: Colors.white,
                        onPress: () =>
                            context.read<Controller>().apply_now(job.jobKey),
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      ),
              ),
              SizedBox(height: 35.0),
            ],
          )),
        ));
  }
}
