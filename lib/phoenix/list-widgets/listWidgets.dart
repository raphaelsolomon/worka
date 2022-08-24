import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/AvailablityModel.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/EducationModel.dart';
import 'package:worka/phoenix/model/ExperienceModel.dart';
import 'package:worka/phoenix/model/LanguageModel.dart';
import 'package:worka/phoenix/model/MySkill.dart';

import '../ProfileController.dart';

Widget skillList(BuildContext context, MySkill skill) => InkWell(
      onTap: () {
        Get.to(() => null);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.1))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText('Skill Name: ${skill.skillName}',
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 5.0),
                  AutoSizeText('Skill Level: ${skill.level}',
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 5.0),
                  AutoSizeText(
                      'Experience: ${skill.yearOfExperience} Experience',
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: SUB_HEAD_1,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: DEFAULT_COLOR))
          ],
        ),
      ),
    );

skillClick(BuildContext context) {
  if (context.read<ProfileController>().skills) {
    context.read<ProfileController>().setSkills(false);
  } else {
    context.read<ProfileController>().setSkills(true);
  }
}

Widget languageList(BuildContext context, LanguageModel lang) => InkWell(
      onTap: () => Get.to(() => null),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('language: ${lang.language}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('Level: ${lang.level}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );

languageClick(BuildContext context) {
  if (context.read<ProfileController>().language) {
    context.read<ProfileController>().setLanguage(false);
  } else {
    context.read<ProfileController>().setLanguage(true);
  }
}

Widget experienceList(BuildContext context, ExperienceModel eModel) => InkWell(
      onTap: () => Get.to(() => null),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('Company Name: ${eModel.companyName}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('Desc: ${eModel.description}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${eModel.current ? 'Forfieted' : 'Still Working'}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('From: ${eModel.startDate}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('To: ${eModel.endDate}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );

experienceClick(BuildContext context) {
  {
    if (context.read<ProfileController>().experience) {
      context.read<ProfileController>().setExperience(false);
    } else {
      context.read<ProfileController>().setExperience(true);
    }
  }
}

Widget educationList(BuildContext context, EducationModel educationModel) =>
    InkWell(
      onTap: () => Get.to(() => null),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('${educationModel.schoolName}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.level}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.certificate}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.course}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.current}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.startDate}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 5.0),
            AutoSizeText('${educationModel.endDate}',
                minFontSize: 11,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: SUB_HEAD_1,
                    fontWeight: FontWeight.normal))
          ],
        ),
      ),
    );

educationClick(BuildContext context) {
  if (context.read<ProfileController>().education) {
    context.read<ProfileController>().setEducation(false);
  } else {
    context.read<ProfileController>().setEducation(true);
  }
}

Widget personalDetails(BuildContext context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AutoSizeText(
          '${context.watch<Controller>().profileModel!.firstName} ${context.watch<Controller>().profileModel!.lastName} ${context.watch<Controller>().profileModel!.otherName}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
      SizedBox(height: 5.0),
      AutoSizeText('${context.watch<Controller>().profileModel!.gender}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
      SizedBox(height: 5.0),
      AutoSizeText('${context.watch<Controller>().profileModel!.user!.email}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
      SizedBox(height: 5.0),
      AutoSizeText('${context.watch<Controller>().profileModel!.phone}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
      SizedBox(height: 5.0),
      AutoSizeText('${context.watch<Controller>().profileModel!.location}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
      SizedBox(height: 5.0),
      AutoSizeText('${context.watch<Controller>().profileModel!.about}',
          minFontSize: 11,
          maxFontSize: 20,
          style: GoogleFonts.montserrat(
              fontSize: 15, color: SUB_HEAD_1, fontWeight: FontWeight.normal)),
    ]);

personalClick(BuildContext context) {
  if (context.read<ProfileController>().experience) {
    context.read<ProfileController>().setPersonalDetails(false);
  } else {
    context.read<ProfileController>().setPersonalDetails(true);
  }
}

Widget availabiltyList(BuildContext context, AvailablityModel eModel) => Row(
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 1.0, color: DEFAULT_COLOR.withOpacity(.1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('Contract: ${eModel.contract}',
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: SUB_HEAD_1,
                        fontWeight: FontWeight.normal)),
                SizedBox(height: 5.0),
                AutoSizeText('Full-Time: ${eModel.fullTime}',
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: SUB_HEAD_1,
                        fontWeight: FontWeight.normal)),
                SizedBox(height: 5.0),
                AutoSizeText('Part-Time: ${eModel.partTime}',
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: SUB_HEAD_1,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.delete, color: DEFAULT_COLOR))
      ],
    );

availableClick(BuildContext context) {
  if (context.read<ProfileController>().availability) {
    context.read<ProfileController>().setAvailablity(false);
  } else {
    context.read<ProfileController>().setAvailablity(true);
  }
}
