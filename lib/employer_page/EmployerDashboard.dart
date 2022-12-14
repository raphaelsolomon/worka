// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/models/login/user_model.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/drawer/re_drawer.dart';
import 'package:worka/redesigns/employer/reViewApplicants.dart';
import 'package:worka/redesigns/employer/re_company_profile.dart';
import 'package:worka/redesigns/employer/re_job_details_emp.dart';
import 'package:worka/redesigns/employer/redesign_post_job.dart';
import 'package:worka/reuseables/general_container.dart';

import '../models/HotAlert.dart';
import '../phoenix/GeneralButtonContainer.dart';
import '../phoenix/model/UserResponse.dart';
import 'phoenix/screens/JobDetails.dart';
import 'controller/empContoller.dart';

class EmployerDashboard extends StatefulWidget {
  EmployerDashboard({Key? key, this.user}) : super(key: key);

  final UserModel? user;

  @override
  State<EmployerDashboard> createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {
  final scaffold = GlobalKey<ScaffoldState>();
  final _controller = RefreshController();
  String name = '';
  String type = '';
  bool isFavorite = true;
  List<MyPosted> postedJobs = [];
  AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  CompModel? compModel = null;
  bool isLoading = true;

  fetchData(BuildContext context) async {
    return await context.read<EmpController>().getEmployerDetails(context);
  }

  @override
  void initState() {
    context
        .read<EmpController>()
        .getPostedJobs(context)
        .then((value) => setState(() {
              postedJobs = value;
            }))
        .whenComplete(() => fetchData(context).then((value) {
              setState(() {
                compModel = value;
                isLoading = false;
              });
            }));
    execute();
    super.initState();
  }

  execute() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    context
        .read<Controller>()
        .setEmail(sharedPreferences.getString(EMAIL) ?? '');
    context.read<Controller>().setUserName(
        '${sharedPreferences.getString(FIRSTNAME)!.capitalizeFirst ?? ''} ${sharedPreferences.getString(LASTNAME)!.capitalizeFirst ?? ''}');
    Plan p = Plan.fromMap(jsonDecode(sharedPreferences.getString(PLAN)!));
    if (p.name.toLowerCase() == 'free') {
      upgradePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      drawer: ReDrawer(scaffold),
      body: SafeArea(
        child: SmartRefresher(
          controller: _controller,
          onRefresh: () => context
              .read<EmpController>()
              .getPostedJobs(context)
              .then((value) => setState(() {
                    postedJobs = value;
                    _controller.refreshCompleted();
                  })),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10.0, 0, 0),
                      child: GestureDetector(
                        onTap: () => scaffold.currentState!.openDrawer(),
                        child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: DEFAULT_COLOR.withOpacity(.0),
                                borderRadius: BorderRadius.circular(3.0)),
                            child: Icon(
                              Icons.menu_rounded,
                              color: DEFAULT_COLOR,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                      child: CircleAvatar(
                        maxRadius: 28.0,
                        backgroundColor: Color(0xff1B6DF9),
                        backgroundImage: NetworkImage(
                            '${context.watch<Controller>().avatar}'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RichText(
                  text: TextSpan(
                      text: 'Hire the Best',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                      children: [
                        TextSpan(
                            text: '\nTalents.',
                            style: GoogleFonts.montserrat(
                                color: Color(0xff0039A5),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1)),
                      ]),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: context.watch<Controller>().hotAlert.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                              height: 100.0,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              reverse: true,
                              autoPlayCurve: Curves.linear),
                          items: context
                              .watch<Controller>()
                              .hotAlert
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Builder(
                                      builder: (context) => carousel(e),
                                    ),
                                  ))
                              .toList(),
                        )
                      : carouselEmpty()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 14, 0, 0),
                    child: Text(
                      'Job Posting',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3F3F3F)),
                    ),
                  ),
                  GeneralContainer(
                    name: 'Post Jobs',
                    onPress: () => Get.to(() => RePostJobs()),
                    paddingLeft: 10,
                    paddingTop: 10,
                    paddingRight: 30,
                    paddingBottom: 0,
                    width: 50,
                    bcolor: const Color(0xffFFFFFF),
                    stroke: 0,
                    height: 30,
                    size: 12,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              isLoading ? Expanded(
                child: Center(child: CircularProgressIndicator(color: DEFAULT_COLOR),)
              ) : Expanded(
                child: Column(children: [
                  if (postedJobs.isEmpty)
                  Expanded(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('No Posted Jobs',
                            style: GoogleFonts.montserrat(
                                fontSize: 20, color: Colors.red)),
                        const SizedBox(height: 10.0),
                        GeneralButtonContainer(
                          name: 'Post a job',
                          color: DEFAULT_COLOR,
                          textColor: Colors.white,
                          onPress: () {
                            Get.to(
                              () => RePostJobs(),
                            );
                          },
                          paddingBottom: 3,
                          paddingLeft: 30,
                          paddingRight: 30,
                          paddingTop: 5,
                        ),
                      ],
                    ),
                  ))
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: postedJobs
                            .map(
                              (e) => InkWell(
                                onTap: () => Get.to(() => ReJobsDetails(e)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          width: 1.5,
                                          color: '${e.access}' == 'open'
                                              ? DEFAULT_COLOR.withOpacity(.8)
                                              : Colors.transparent)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                DEFAULT_COLOR.withOpacity(.03),
                                            radius: 28.0,
                                            backgroundImage: NetworkImage(
                                                '${context.watch<Controller>().avatar}'),
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
                                                  '${compModel!.companyName}',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 18.0,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 2.0,
                                                ),
                                                Text(
                                                  '${compModel!.companyEmail}',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 13.0,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        '${e.title}'.capitalize!,
                                        style: GoogleFonts.lato(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 17.0,
                                                    color: Colors.black26),
                                                Text(
                                                  '${compModel!.location}',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.green),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color:
                                                    Colors.green.withOpacity(.1)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2.5),
                                            child: Text(
                                              '${e.access}',
                                              style: GoogleFonts.lato(
                                                  fontSize: 12.5,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                        thickness: .5,
                                      ),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${e.applications} Applicants',
                                            style: GoogleFonts.lato(
                                                fontSize: 13.0,
                                                color: Colors.black54),
                                          ),
                                          InkWell(
                                            onTap: () => Get.to(() =>
                                                ReViewApplicant(e, compModel!)),
                                            child: Text(
                                              'View all',
                                              style: GoogleFonts.lato(
                                                  fontSize: 13.0,
                                                  color: DEFAULT_COLOR),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        // children: myList
                        //     .map((e) => hotListingMethod(e, '${e.jobKey}', '${e.title}',
                        //         '${e.budget}', '${e.location}'))
                        //     .toList(),
                      ),
                    ),
                  )
                ],),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget carousel(HotAlert e) => GestureDetector(
        onTap: () {
          if (e.link == 'profile') {
            Get.to(() => ReCompanyProfile());
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff0039A5),
              boxShadow: [
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/alert.png',
                            ),
                            Text(
                              'Alerts',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                    child: Text(
                      '${e.message}',
                      style: GoogleFonts.montserrat(
                          fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color(0xffF5F5F5),
                height: 70,
                width: 1,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      );

  Padding hotListingMethod(
      MyPosted e, String id, String job, String sly, String locate) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: DEFAULT_COLOR.withOpacity(.5), width: .2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xff0039A5),
                      backgroundImage:
                          NetworkImage(context.watch<Controller>().avatar)),
                  AutoSizeText.rich(TextSpan(
                      text: 'status: ',
                      style: GoogleFonts.montserrat(),
                      children: [
                        TextSpan(
                            text: '${e.access}',
                            style: GoogleFonts.montserrat(color: DEFAULT_COLOR))
                      ]))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: AutoSizeText(
                job,
                minFontSize: 12,
                maxFontSize: 20,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: AutoSizeText(
                      sly,
                      minFontSize: 12,
                      maxFontSize: 20,
                      maxLines: 1,
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: AutoSizeText(
                      locate,
                      minFontSize: 12,
                      maxLines: 1,
                      maxFontSize: 20,
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Flexible(
                    child: InkWell(
                  // onTap: () => Get.to(() => Applications(id, job)),
                  onTap: () => Get.to(() => JobDetailsEmp(e)),
                  child: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: DEFAULT_COLOR,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: AutoSizeText('Preview',
                            minFontSize: 10,
                            maxFontSize: 17,
                            style: GoogleFonts.montserrat(color: Colors.white)),
                      )),
                )),
              ],
            ),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }
  Widget carouselEmpty() => GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xff0039A5),
              boxShadow: [
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/alert.png',
                            ),
                            Text(
                              'Alerts',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                    child: Text(
                      'No new application, keep applying....',
                      style: GoogleFonts.montserrat(
                          fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color(0xffF5F5F5),
                height: 70,
                width: 1,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      );
}
