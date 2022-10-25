import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/applicant/profile/additional_information.dart';
import 'package:worka/redesigns/applicant/profile/professional_summary.dart';
import 'package:worka/redesigns/applicant/profile/re_availability.dart';
import 'package:worka/redesigns/applicant/profile/re_certification.dart';
import 'package:worka/redesigns/applicant/profile/re_education.dart';
import 'package:worka/redesigns/applicant/profile/re_experience.dart';
import 'package:worka/redesigns/applicant/profile/re_language.dart';
import 'package:worka/redesigns/applicant/profile/re_resume_cv.dart';
import 'package:worka/redesigns/applicant/profile/re_skills.dart';
import 'package:worka/redesigns/applicant/re_edit_applicant.dart';

class ReApplicantProfile extends StatefulWidget {
  const ReApplicantProfile({super.key});

  @override
  State<ReApplicantProfile> createState() => _ReApplicantProfileState();
}

class _ReApplicantProfileState extends State<ReApplicantProfile> {
  bool isLoading = false;
  List<bool> allList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
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
            height: 10.0,
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
                Text(
                  'Profile',
                  style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    width: .9, color: Colors.black12.withOpacity(.3))),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                  radius: 30,
                  backgroundImage: NetworkImage(''),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oluwatobi Ogunjimi',
                        style: GoogleFonts.lato(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Production Manager',
                        style: GoogleFonts.lato(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: DEFAULT_COLOR,
                    size: 18.0,
                  ),
                  onPressed: () => Get.to(() => ReApplicantProfileEdit()),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: DEFAULT_COLOR,
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        GestureDetector(
                            onTap: () {
                              allList[9] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 9) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items('Contact Information', Icons.person,
                                () => Get.to(() => null), allList[9])),
                        //============contact information============
                        allList[9] ? _contactInfo() : SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[0] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 0) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Professional Summary',
                                Icons.book_rounded,
                                () => Get.to(() => ProfessionalSummary()),
                                allList[0])),
                        //============professional summary============
                        allList[0]
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8.0),
                                  Text(TERM1,
                                      style: GoogleFonts.lato(
                                          fontSize: 13.0,
                                          color: Colors.black54)),
                                  const SizedBox(height: 15.0),
                                ],
                              )
                            : SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[1] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 1) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Education',
                                Icons.book,
                                () => Get.to(() => RedesignEducation()),
                                allList[1])),
                        allList[1]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.03),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.book_online,
                                                    color: DEFAULT_COLOR_1,
                                                    size: 18.0,
                                                  )),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Computer Science',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Federal University of Design',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Sept 2022 - Sept 2023',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      Get.to(() => null),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black54,
                                                  ))
                                            ],
                                          ),
                                        )),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[2] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 2) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Work Experience',
                                Icons.work_history,
                                () => Get.to(() => RedesignExperience()),
                                allList[2])),
                        //======================Experience==================
                        allList[1]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.03),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.book_online,
                                                    color: DEFAULT_COLOR_1,
                                                    size: 18.0,
                                                  )),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Production Manager',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Google LLC',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Sept 2022 - Sept 2023',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      Get.to(() => null),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black54,
                                                  ))
                                            ],
                                          ),
                                        )),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[3] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 3) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Skills',
                                Icons.trending_down,
                                () => Get.to(() => RedesignSkills()),
                                allList[3])),
                        //===========================SKILLS===========================
                        allList[3]
                            ? Wrap(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                            color:
                                                DEFAULT_COLOR.withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                width: .5,
                                                color: DEFAULT_COLOR)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Javascript',
                                                style: GoogleFonts.lato(
                                                    fontSize: 15.0,
                                                    color: DEFAULT_COLOR)),
                                            const SizedBox(width: 15.0),
                                            GestureDetector(
                                              onTap: () => setState(() => null),
                                              child: Text('x',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 16.0,
                                                      color: DEFAULT_COLOR)),
                                            ),
                                          ],
                                        ))),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[4] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 4) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Certification',
                                Icons.star_border_outlined,
                                () => Get.to(() => Redesigncertification()),
                                allList[4])),
                        //======================Cerification==================
                        allList[4]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.03),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: DEFAULT_COLOR_1,
                                                    size: 18.0,
                                                  )),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Production Manager',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Google LLC',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Sept 2022 - Sept 2023',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      Get.to(() => null),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black54,
                                                  ))
                                            ],
                                          ),
                                        )),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[5] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 5) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Languages',
                                Icons.person,
                                () => Get.to(() => RedesignLanguage()),
                                allList[5])),
                        //======================Experience==================
                        allList[5]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.03),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.book_online,
                                                    color: DEFAULT_COLOR_1,
                                                    size: 18.0,
                                                  )),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'English',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Native or Billingual Proficiency',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      Get.to(() => null),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black54,
                                                  ))
                                            ],
                                          ),
                                        )),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[6] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 6) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Availablility',
                                Icons.timelapse,
                                () => Get.to(() => RedesignAvailability()),
                                allList[6])),
                        //======================Availability==================
                        allList[6]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                    2,
                                    (i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.03),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.timelapse,
                                                    color: DEFAULT_COLOR_1,
                                                    size: 18.0,
                                                  )),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Available to work Fulltime',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Open to jobs',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      Get.to(() => null),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black54,
                                                  ))
                                            ],
                                          ),
                                        )),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[7] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 7) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Resume/CV',
                                Icons.file_open,
                                () => Get.to(() => RedesignResume()),
                                allList[7])),
                        //======================RESUME/CV==================
                        allList[7]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                ...List.generate(
                                  2,
                                  (i) => GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15.0),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color:
                                              DEFAULT_COLOR_1.withOpacity(.1)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_open,
                                            color: DEFAULT_COLOR_1,
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Attach File.pdf',
                                                  style: GoogleFonts.lato(
                                                      color: Colors.black54,
                                                      fontSize: 15.0),
                                                ),
                                                Text(
                                                  '199Kb',
                                                  style: GoogleFonts.lato(
                                                      color: Colors.black54,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                        GestureDetector(
                            onTap: () {
                              allList[8] = true;
                              for (int i = 1; i < allList.length; i++) {
                                if (i != 8) {
                                  allList[i] = false;
                                }
                              }
                              setState(() {});
                            },
                            child: _items(
                                'Additional Information',
                                Icons.person_add,
                                () => Get.to(() => AdditionalInformation()),
                                allList[8])),
                        //======================ADDITIONAL INFORMATION==================
                        allList[7]
                            ? Column(children: [
                                const SizedBox(height: 8.0),
                                Text(TERM1,
                                    style: GoogleFonts.lato(
                                        fontSize: 13.0, color: Colors.black54)),
                                const SizedBox(height: 15.0),
                              ])
                            : const SizedBox(),
                      ]))))
        ],
      )),
    );
  }

  Widget _items(text, icon, callBack, isExpanded) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: !isExpanded
            ? Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: DEFAULT_COLOR_1,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 18.0,
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(text,
                              style: GoogleFonts.lato(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () => callBack(),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: DEFAULT_COLOR_1,
                          size: 18.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  Divider(),
                ],
              )
            : Container(
                height: 45.0,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: .5),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: DEFAULT_COLOR_1,
                      size: 18.0,
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(text,
                            style: GoogleFonts.lato(
                                fontSize: 15.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600))),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      color: DEFAULT_COLOR_1,
                      size: 18.0,
                    )
                  ],
                ),
              ),
      );

  Widget _contactInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          Row(
            children: [
              Icon(Icons.email_rounded, color: Colors.black54, size: 18.0),
              const SizedBox(
                width: 10.0,
              ),
              Text('Lagos, Nigeria',
                  style:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
            ],
          ),
          const SizedBox(height: 3.0),
          Row(
            children: [
              Icon(Icons.email_rounded, color: Colors.black54, size: 18.0),
              const SizedBox(
                width: 10.0,
              ),
              Text('info@Fklynetwork.inc',
                  style:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
            ],
          ),
          const SizedBox(height: 3.0),
          Row(
            children: [
              Icon(Icons.email_rounded, color: Colors.black54, size: 18.0),
              const SizedBox(
                width: 10.0,
              ),
              Text('+234 708 9704 086',
                  style:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
            ],
          ),
          const SizedBox(height: 15.0),
        ],
      );
}
