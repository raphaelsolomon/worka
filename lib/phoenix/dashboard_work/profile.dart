import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/availablility/add-availability.dart';
import 'package:worka/phoenix/dashboard_work/education/addEducation.dart';
import 'package:worka/phoenix/dashboard_work/preview.dart';
import 'package:worka/phoenix/dashboard_work/skills/edit-skill.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';
import 'education/edit-education.dart';
import 'experience/addExperience.dart';
import 'experience/edit-experience.dart';
import 'language/edit-language.dart';
import 'personal-details.dart';
import 'skills/add-skill.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final c = TextEditingController();
  final _smartController = RefreshController();
  final addCtl = TextEditingController();
  //=====================================================================

  @override
  void initState() {
    context.read<Controller>().getprofileReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var item = context.watch<Controller>().profileModel;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SmartRefresher(
          controller: _smartController,
          child: Container(
            child: Column(
              children: [
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
                      Text('Profile',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Color(0xff0D30D9))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(null),
                          color: Colors.black,
                          onPressed: null,
                        ),
                      )
                    ]),
                const SizedBox(height: 5.0),
                imageView('${context.watch<Controller>().avatar}',
                    callBack: () async {
                  try {
                    final file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    context.read<Controller>().uploadImage(file!.path);
                  } on MissingPluginException {}
                }),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                          '${item!.firstName} ${item.lastName} ${item.otherName}'
                              .toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontSize: 21,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center),
                    ),
                    IconButton(
                        onPressed: () {
                          print(setMap());
                          Get.to(() => PersonalDetails(setMap()));
                        },
                        icon: Icon(Icons.edit, color: DEFAULT_COLOR))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${item.user!.email}',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.left),
                    const SizedBox(width: 5.0),
                    Icon(Icons.mail, size: 18.0, color: DEFAULT_COLOR),
                  ],
                ),
                SizedBox(height: 7.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${item.phone}',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.left),
                    const SizedBox(width: 7.0),
                    Icon(Icons.phone, size: 18.0, color: DEFAULT_COLOR),
                  ],
                ),
                SizedBox(height: 3.0),
                Text('${item.location}\n${item.gender!.capitalizeFirst}',
                    style: GoogleFonts.montserrat(
                      height: 1.5,
                        fontSize: 15, color: Colors.grey),
                    textAlign: TextAlign.center),
                SizedBox(height: 5.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: ReadMoreText(
                      '${item.about}',
                      textAlign: TextAlign.justify,
                      trimLines: 1,
                      colorClickableText: DEFAULT_COLOR,
                      trimMode: TrimMode.Line,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      trimCollapsedText: '\nShow more',
                      trimExpandedText: '\nShow less',
                      moreStyle: GoogleFonts.montserrat(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                      lessStyle: GoogleFonts.montserrat(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(
                    child: Container(
                  child: context.watch<Controller>().profileModel == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        'Education',
                                        minFontSize: 11,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => AddEducation());
                                      },
                                      icon:
                                          Icon(Icons.add, color: DEFAULT_COLOR),
                                    )
                                  ],
                                ),
                                item.education!.isEmpty
                                    ? Text('No Education History',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                    : Column(children: [
                                        ...item.education!
                                            .map((e) => educationList(e))
                                            .toList()
                                      ]),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        'Skills',
                                        minFontSize: 11,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => AddSkills());
                                      },
                                      icon:
                                          Icon(Icons.add, color: DEFAULT_COLOR),
                                    )
                                  ],
                                ),
                                item.skill!.isEmpty
                                    ? Text('No Skill History',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                    : Column(children: [
                                        ...item.skill!
                                            .map((e) => skillList(e))
                                            .toList()
                                      ]),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        'Experience',
                                        minFontSize: 11,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => AddExperience());
                                      },
                                      icon:
                                          Icon(Icons.add, color: DEFAULT_COLOR),
                                    )
                                  ],
                                ),
                                item.workExperience!.isEmpty
                                    ? Text('No Work Experience History',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                    : Column(children: [
                                        ...item.workExperience!
                                            .map((e) => experienceList(e))
                                            .toList()
                                      ]),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        'Language',
                                        minFontSize: 11,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => Screens(
                                            selectLanguage(context, c)));
                                      },
                                      icon:
                                          Icon(Icons.add, color: DEFAULT_COLOR),
                                    )
                                  ],
                                ),
                                item.language!.isEmpty
                                    ? Text('No Language History',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                    : Column(children: [
                                        ...item.language!
                                            .map((e) => languageList(e))
                                            .toList()
                                      ]),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        'Availability',
                                        minFontSize: 11,
                                        maxFontSize: 25,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => AddAvailablity());
                                      },
                                      icon:
                                          Icon(Icons.add, color: DEFAULT_COLOR),
                                    )
                                  ],
                                ),
                                ...item.availability!
                                    .map((e) => availableList(e))
                                    .toList(),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                ))
              ],
            ),
          ),
        )));
  }

  Widget educationList(Education? educationModel) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.05))),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                            '${educationModel!.schoolName}'.capitalizeFirst!,
                            minFontSize: 16,
                            maxFontSize: 16,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: AutoSizeText.rich(
                              TextSpan(
                                  text: 'Course: ',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black38),
                                  children: [
                                    TextSpan(
                                        text: '${educationModel.course}'
                                            .capitalizeFirst!,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                  ]),
                              minFontSize: 11,
                              maxFontSize: 20,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                                text: '${educationModel.certificate}'
                                    .capitalizeFirst!,
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
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText.rich(
                            TextSpan(
                                text: 'from: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black38),
                                children: [
                                  TextSpan(
                                      text:
                                          '${DateFormat('yyyy-MM-dd').format(educationModel.startDate)}',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black))
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
                                text: 'to: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black38),
                                children: [
                                  TextSpan(
                                      text:
                                          '${DateFormat('yyyy-MM-dd').format(educationModel.startDate)}',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black))
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
            ),
            IconButton(
                onPressed: () => Get.to(() => EditEducation(educationModel)),
                icon: Icon(Icons.edit, color: DEFAULT_COLOR))
          ],
        ),
      );

  Widget skillList(Skill? skill) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.05))),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
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
            IconButton(
                onPressed: () => Get.to(() => EditSkill(skill)),
                icon: Icon(Icons.edit, color: DEFAULT_COLOR))
          ],
        ),
      );

  Widget languageList(Language? lang) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.05))),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
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
            IconButton(
                onPressed: () => Get.to(() => EditLanguage(lang)),
                icon: Icon(Icons.edit, color: DEFAULT_COLOR))
          ],
        ),
      );

  Widget experienceList(WorkExperience? eModel) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.05))),
        child: Row(
          children: [
            Flexible(
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
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                    lessStyle: GoogleFonts.montserrat(
                        fontSize: 11,
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
                                text: 'from: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black38),
                                children: [
                                  TextSpan(
                                      text:
                                          '${DateFormat('yyyy-MM-dd').format(eModel.startDate)}',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black))
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
                                text: 'to: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black38),
                                children: [
                                  TextSpan(
                                      text:
                                          '${DateFormat('yyyy-MM-dd').format(eModel.startDate)}',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black))
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
            ),
            IconButton(
                onPressed: () => Get.to(() => EditExperience(eModel)),
                icon: Icon(Icons.edit, color: DEFAULT_COLOR))
          ],
        ),
      );

  Widget availableList(Availability a) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 1.0, color: DEFAULT_COLOR.withOpacity(.05))),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(value: a.contract, onChanged: (b) {}),
                      AutoSizeText('Contract',
                          minFontSize: 11,
                          maxFontSize: 16,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Checkbox(value: a.fullTime, onChanged: (b) {}),
                      AutoSizeText('Full Time',
                          minFontSize: 11,
                          maxFontSize: 16,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Checkbox(value: a.partTime, onChanged: (b) {}),
                      AutoSizeText('Part Time',
                          minFontSize: 11,
                          maxFontSize: 16,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            // IconButton(
            //     onPressed: () => Get.to(() => null),
            //     icon: Icon(Icons.edit, color: DEFAULT_COLOR))
          ],
        ),
      );

  setMap() {
    if (context.read<Controller>().profileModel!.location!.isNotEmpty) {
      var s = context.read<Controller>().profileModel!.location!.split(', ');
      return {
        'firstname': context.read<Controller>().profileModel!.firstName,
        'lastname': context.read<Controller>().profileModel!.lastName,
        'othername': context.read<Controller>().profileModel!.otherName,
        'countryValue': s.length >= 3 ? s[2] : '',
        'phone': context.read<Controller>().profileModel!.phone,
        'stateValue': s.length >= 2 ? s[1] : '',
        'cityValue': s.length >= 0 ? s[0] : '',
        'about': context.read<Controller>().profileModel!.about,
      };
    }
    return {
      'firstname': context.read<Controller>().profileModel!.firstName,
      'lastname': context.read<Controller>().profileModel!.lastName,
      'othername': context.read<Controller>().profileModel!.otherName,
      'countryValue': '',
      'phone': context.read<Controller>().profileModel!.phone,
      'stateValue': '',
      'cityValue': '',
      'about': context.read<Controller>().profileModel!.about,
    };
  }
}
