import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';
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
  ProfileModel? profileModel = null;
  bool pageLoading = true;
  final refresh = RefreshController();

  _fetchProfile() async {
    return await context.read<Controller>().getprofileReview();
  }

  @override
  void initState() {
    _fetchProfile().then((value) => setState(() {
          profileModel = value;
          pageLoading = false;
        }));
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
          Expanded(
              child: pageLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: DEFAULT_COLOR,
                    ))
                  : SmartRefresher(
                      controller: refresh,
                      header: WaterDropHeader(),
                      onRefresh: () =>
                          _fetchProfile().then((value) => setState(() {
                                profileModel = value;
                                refresh.refreshCompleted();
                              })),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      width: .9,
                                      color: Colors.black12.withOpacity(.3))),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        DEFAULT_COLOR.withOpacity(.03),
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        '${profileModel!.displayPicture}'),
                                  ),
                                  const SizedBox(
                                    width: 25.0,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${profileModel!.firstName} ${profileModel!.lastName}',
                                          style: GoogleFonts.lato(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '${profileModel!.keySkills}',
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
                                    onPressed: () =>
                                        Get.to(() => ReApplicantProfileEdit(profileModel!)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  allList[9] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 9) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Contact Information',
                                    Icons.person,
                                    () => Get.to(() => null),
                                    allList[9])),
                            //============contact information============
                            allList[9] ? _contactInfo() : SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[0] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    if (i != 0) {
                                      allList[i] = false;
                                    }
                                  }
                                  setState(() {});
                                },
                                child: _items(
                                    'Professional Summary',
                                    Icons.book_rounded,
                                    () => Get.to(() => ProfessionalSummary('')),
                                    allList[0])),
                            //============professional summary============
                            allList[0]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8.0),
                                        GestureDetector(
                                          onTap: () => Get.to(() =>
                                              ProfessionalSummary('${profileModel!.profileSummary!}')),
                                          child: Text(
                                              profileModel!.profileSummary!,
                                              style: GoogleFonts.lato(
                                                  fontSize: 13.0,
                                                  color: Colors.black54)),
                                        ),
                                        const SizedBox(height: 15.0),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[1] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 1) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Education',
                                    Icons.book,
                                    () => Get.to(() => RedesignEducation(isEdit: false)),
                                    allList[1])),
                            allList[1]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          profileModel!.education!.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: GestureDetector(
                                                  onTap: () => Get.to(() => RedesignEducation(isEdit: true, eModel: profileModel!.education![i])),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .03),
                                                          radius: 20,
                                                          child: Icon(
                                                            Icons.book_online,
                                                            color:
                                                                DEFAULT_COLOR_1,
                                                            size: 18.0,
                                                          )),
                                                      const SizedBox(
                                                        width: 25.0,
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${profileModel!.education![i].course}'
                                                                  .capitalize!,
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 16.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${profileModel!.education![i].schoolName}'
                                                                  .capitalize!,
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${DateFormat('EEEE, MMM, yyyy').format(DateTime.parse(profileModel!.education![i].startDate!))}, - ${DateFormat('EEEE, MMM, yyyy').format(DateTime.parse(profileModel!.education![i].endDate!))}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                ),
                                              )),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[2] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 2) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Work Experience',
                                    Icons.work_history,
                                    () => Get.to(() => RedesignExperience(isEdit: false)),
                                    allList[2])),
                            //======================Experience==================
                            allList[2]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          profileModel!.workExperience!.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: GestureDetector(
                                                  onTap: () => Get.to(() => RedesignExperience(isEdit: true, eModel: profileModel!.workExperience![i],)),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .03),
                                                          radius: 20,
                                                          child: Icon(
                                                            Icons.book_online,
                                                            color:
                                                                DEFAULT_COLOR_1,
                                                            size: 18.0,
                                                          )),
                                                      const SizedBox(
                                                        width: 25.0,
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${profileModel!.workExperience![i].title}'
                                                                  .capitalize!,
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 16.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${profileModel!.workExperience![i].companyName}'
                                                                  .capitalize!,
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${DateFormat('EEEE, MMM, yyyy').format(DateTime.parse(profileModel!.workExperience![i].startDate!))}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                ),
                                              )),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[3] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 3) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Skills',
                                    Icons.trending_down,
                                    () => Get.to(() => RedesignSkills(isEdit: false)),
                                    allList[3])),
                            //===========================SKILLS===========================
                            allList[3]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Wrap(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          2,
                                          (i) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  color: DEFAULT_COLOR
                                                      .withOpacity(.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      width: .5,
                                                      color: DEFAULT_COLOR)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Javascript',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15.0,
                                                          color:
                                                              DEFAULT_COLOR)),
                                                  const SizedBox(width: 15.0),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        setState(() => null),
                                                    child: Text('x',
                                                        style: GoogleFonts.lato(
                                                            fontSize: 16.0,
                                                            color:
                                                                DEFAULT_COLOR)),
                                                  ),
                                                ],
                                              ))),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[4] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 4) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Certification',
                                    Icons.star_border_outlined,
                                    () => Get.to(() => Redesigncertification(isEdit: false)),
                                    allList[4])),
                            //======================Cerification==================
                            allList[4]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          profileModel!.certificate!.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: GestureDetector(
                                                  onTap: () => Get.to(() => Redesigncertification(isEdit: true, eModel: profileModel!.certificate![i],)),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .03),
                                                          radius: 20,
                                                          child: Icon(
                                                            Icons.star,
                                                            color:
                                                                DEFAULT_COLOR_1,
                                                            size: 18.0,
                                                          )),
                                                      const SizedBox(
                                                        width: 25.0,
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${profileModel!.certificate![i].title}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 16.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${profileModel!.certificate![i].issuer}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${DateFormat('EEEE, MMM, yyyy').format(DateTime.parse(profileModel!.certificate![i].dated!))}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                ),
                                              )),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[5] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 5) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Languages',
                                    Icons.person,
                                    () => Get.to(() => RedesignLanguage(isEdit: false)),
                                    allList[5])),
                            //======================Experience==================
                            allList[5]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          profileModel!.language!.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: GestureDetector(
                                                  onTap: () => Get.to(() => RedesignLanguage(isEdit: true, eModel: profileModel!.language![i],)),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .03),
                                                          radius: 20,
                                                          child: Icon(
                                                            Icons.book_online,
                                                            color:
                                                                DEFAULT_COLOR_1,
                                                            size: 18.0,
                                                          )),
                                                      const SizedBox(
                                                        width: 25.0,
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${profileModel!.language![i].language}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 16.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              '${profileModel!.language![i].level}',
                                                              style: GoogleFonts.lato(
                                                                  fontSize: 13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                ),
                                              )),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[6] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 6) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Availablility',
                                    Icons.timelapse,
                                    () => Get.to(() =>
                                        RedesignAvailability(edit: false)),
                                    allList[6])),
                            //======================Availability==================
                            allList[6]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      ...List.generate(
                                          1,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: GestureDetector(
                                                  onTap: () => Get.to(() =>
                                                      RedesignAvailability(
                                                        edit: true,
                                                        update: profileModel!
                                                            .availability![i],
                                                      )),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .03),
                                                          radius: 20,
                                                          child: Icon(
                                                            Icons.timelapse,
                                                            color:
                                                                DEFAULT_COLOR_1,
                                                            size: 18.0,
                                                          )),
                                                      const SizedBox(
                                                        width: 25.0,
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              profileModel!
                                                                      .availability![i]
                                                                      .fullTime!
                                                                  ? 'Available to work Fulltime'
                                                                  : 'Not available to work fulltime',
                                                              style: GoogleFonts.lato(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 6.0,
                                                            ),
                                                            Text(
                                                              'Open to jobs',
                                                              style: GoogleFonts.lato(
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () =>
                                                              Get.to(
                                                                  () => null),
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color:
                                                                Colors.black54,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              )),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[7] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 7) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Resume/CV',
                                    Icons.file_open,
                                    () => Get.to(() => RedesignResume()),
                                    allList[7])),
                            //======================RESUME/CV==================
                            allList[7]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      profileModel!.cv == null ||
                                              profileModel!.cv!.isEmpty
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                  child: Text(
                                                      'No Resume/CV Found',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 14.0,
                                                          color:
                                                              Colors.black54))))
                                          : Container(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: DEFAULT_COLOR_1
                                                      .withOpacity(.1)),
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
                                                    fit: FlexFit.tight,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${p.basename(profileModel!.cv!)}',
                                                          style: GoogleFonts
                                                              .lato(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      15.0),
                                                        ),
                                                        Text(
                                                          '',
                                                          style: GoogleFonts
                                                              .lato(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      12.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    size: 18.0,
                                                    color: Colors.redAccent,
                                                  ),
                                                  const SizedBox(
                                                    width: 20.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                                onTap: () {
                                  allList[8] = true;
                                  for (int i = 0; i < allList.length; i++) {
                                    setState(() {
                                      if (i != 8) {
                                        allList[i] = false;
                                      }
                                    });
                                  }
                                },
                                child: _items(
                                    'Additional Information',
                                    Icons.person_add,
                                    () =>
                                        Get.to(() => AdditionalInformation('')),
                                    allList[8])),
                            //======================ADDITIONAL INFORMATION==================
                            allList[8]
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(children: [
                                      const SizedBox(height: 8.0),
                                      GestureDetector(
                                        onTap: () => Get.to(() =>
                                            AdditionalInformation(
                                                '${profileModel!.about!}')),
                                        child: Text(profileModel!.about!,
                                            style: GoogleFonts.lato(
                                                fontSize: 13.0,
                                                color: Colors.black54)),
                                      ),
                                      const SizedBox(height: 15.0),
                                    ]),
                                  )
                                : const SizedBox(),
                          ]))),
                    ))
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

  Widget _contactInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.black54, size: 18.0),
                const SizedBox(
                  width: 10.0,
                ),
                Text('Lagos, Nigeria',
                    style:
                        GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
              ],
            ),
            const SizedBox(height: 7.0),
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
            const SizedBox(height: 7.0),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.black54, size: 18.0),
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
        ),
      );
}
