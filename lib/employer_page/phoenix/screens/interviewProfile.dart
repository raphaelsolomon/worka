import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/ViewAppModel.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';

class InterviewProfile extends StatefulWidget {
  final String id;
  final String display;
  InterviewProfile(this.id, this.display, {Key? key}) : super(key: key);

  @override
  State<InterviewProfile> createState() => _InterviewProfileState();
}

class _InterviewProfileState extends State<InterviewProfile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Profile',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                )
              ]),
              SizedBox(height: 10.0),
              FutureBuilder(
                  future: context
                      .read<EmpController>()
                      .viewApplicationList(context, widget.id),
                  builder: (ctx, snapshot) => customExecute(snapshot))
            ],
          ),
        )));
  }

  Widget _container(ViewAppModel item) => Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        imageView(widget.display, context),
        SizedBox(height: 15.0),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    '${item.firstName} ${item.lastName} ${item.otherName}'
                        .toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
                SizedBox(height: 5.0),
                Text('${item.location}, ${item.gender!.capitalizeFirst}',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey),
                    textAlign: TextAlign.left),
                SizedBox(height: 10.0),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 276,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: ReadMoreText(
                                  '${item.about}',
                                  trimLines: 1,
                                  colorClickableText: DEFAULT_COLOR,
                                  trimMode: TrimMode.Line,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  trimCollapsedText: '\nShow more',
                                  trimExpandedText: '\nShow less',
                                  moreStyle: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue),
                                  lessStyle: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText('Education',
                                minFontSize: 11,
                                maxFontSize: 25,
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.0),
                            ...item.education!
                                .map((e) => educationList(e))
                                .toList(),
                            SizedBox(height: 20.0),
                            AutoSizeText('Skills',
                                minFontSize: 11,
                                maxFontSize: 25,
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.0),
                            ...item.skill!.map((e) => skillList(e)).toList(),
                            SizedBox(height: 20.0),
                            AutoSizeText('Experience',
                                minFontSize: 11,
                                maxFontSize: 25,
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.0),
                            ...item.workExperience!
                                .map((e) => experienceList(e))
                                .toList(),
                            SizedBox(height: 20.0),
                            AutoSizeText('Language',
                                minFontSize: 11,
                                maxFontSize: 25,
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.0),
                            ...item.language!
                                .map((e) => languageList(e))
                                .toList(),
                            SizedBox(height: 20.0),
                          ]),
                    ))
              ],
            )),
      ]));

  Widget educationList(Education? educationModel) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border:
              Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.08))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeText(
                    '${educationModel!.schoolName}'.capitalizeFirst!,
                    minFontSize: 11,
                    maxFontSize: 16,
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText.rich(
                      TextSpan(
                          text: 'Course: ',
                          style: GoogleFonts.montserrat(color: Colors.black38),
                          children: [
                            TextSpan(
                                text:
                                    '${educationModel.course}'.capitalizeFirst!,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 13.5,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          AutoSizeText.rich(
              TextSpan(
                  text: 'Degree: ',
                  style: GoogleFonts.montserrat(color: Colors.black38),
                  children: [
                    TextSpan(
                        text: '${educationModel.certificate}'.capitalizeFirst!,
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w500))
                  ]),
              minFontSize: 11,
              maxFontSize: 20,
              style: GoogleFonts.montserrat(
                  fontSize: 13.5,
                  color: SUB_HEAD_1,
                  fontWeight: FontWeight.normal)),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeText.rich(
                    TextSpan(
                        text: 'start date: ',
                        style: GoogleFonts.montserrat(color: Colors.black38),
                        children: [
                          TextSpan(
                              text:
                                  '${DateFormat('yyyy-MM-dd').format(educationModel.startDate)}',
                              style:
                                  GoogleFonts.montserrat(color: Colors.black))
                        ]),
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 13.5,
                        color: SUB_HEAD_1,
                        fontWeight: FontWeight.normal)),
              ),
              Flexible(
                child: AutoSizeText.rich(
                    TextSpan(
                        text: 'start date: ',
                        style: GoogleFonts.montserrat(color: Colors.black38),
                        children: [
                          TextSpan(
                              text:
                                  '${DateFormat('yyyy-MM-dd').format(educationModel.startDate)}',
                              style:
                                  GoogleFonts.montserrat(color: Colors.black))
                        ]),
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 13.5,
                        color: SUB_HEAD_1,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          )
        ],
      ));

  Widget skillList(Skill? skill) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.08))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText('${skill!.skillName}'.capitalizeFirst!,
                      minFontSize: 11,
                      maxFontSize: 16,
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 5.0),
                  AutoSizeText.rich(
                      TextSpan(
                          text: 'skill level: ',
                          style: GoogleFonts.montserrat(
                              color: Colors.black38, fontSize: 14),
                          children: [
                            TextSpan(
                                text: '${skill.level}'.capitalizeFirst!,
                                style:
                                    GoogleFonts.montserrat(color: Colors.black))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 5.0),
                  AutoSizeText.rich(
                      TextSpan(
                          text: 'Experience: ',
                          style: GoogleFonts.montserrat(
                              color: Colors.black38, fontSize: 14),
                          children: [
                            TextSpan(
                                text: '${skill.yearOfExperience} Experience',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget languageList(Language? lang) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.08))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText('${lang!.language}'.capitalizeFirst!,
                      minFontSize: 11,
                      maxFontSize: 16,
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 5.0),
                  AutoSizeText.rich(
                      TextSpan(
                          text: 'level: ',
                          style: GoogleFonts.montserrat(
                              color: Colors.black38, fontSize: 14),
                          children: [
                            TextSpan(
                                text: '${lang.level}'.capitalizeFirst!,
                                style:
                                    GoogleFonts.montserrat(color: Colors.black))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget experienceList(WorkExperience? eModel) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.08))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('${eModel!.companyName}'.capitalizeFirst!,
                minFontSize: 11,
                maxFontSize: 16,
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 5.0),
            ReadMoreText(
              '${eModel.description}',
              trimLines: 1,
              colorClickableText: DEFAULT_COLOR,
              trimMode: TrimMode.Line,
              style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontSize: 15,
              ),
              trimCollapsedText: '\nShow more',
              trimExpandedText: '\nShow less',
              moreStyle: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue),
              lessStyle: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue),
            ),
            SizedBox(height: 5.0),
            AutoSizeText(
                '${eModel.current == true ? 'Forfieted' : 'Still Working'}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AutoSizeText.rich(
                      TextSpan(
                          text: 'start date: ',
                          style: GoogleFonts.montserrat(color: Colors.black38),
                          children: [
                            TextSpan(
                                text:
                                    '${DateFormat('yyyy-MM-dd').format(eModel.startDate)}',
                                style:
                                    GoogleFonts.montserrat(color: Colors.black))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 13.5,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ),
                Flexible(
                  child: AutoSizeText.rich(
                      TextSpan(
                          text: 'start date: ',
                          style: GoogleFonts.montserrat(color: Colors.black38),
                          children: [
                            TextSpan(
                                text:
                                    '${DateFormat('yyyy-MM-dd').format(eModel.startDate)}',
                                style:
                                    GoogleFonts.montserrat(color: Colors.black))
                          ]),
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 13.5,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ),
              ],
            )
          ],
        ),
      );

  Widget customExecute(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SizedBox(
        child: Center(child: CircularProgressIndicator()),
        height: MediaQuery.of(context).size.height - 110,
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Center(child: const Text('Error'));
      } else if (snapshot.hasData) {
        return _container(snapshot.data);
      } else {
        return Center(child: const Text('Empty data'));
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
}
