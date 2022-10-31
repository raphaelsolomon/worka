import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/models/HotAlert.dart';
import 'package:worka/models/login/user_model.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/dashboard_work/JobDetailsScreen.dart';
import 'package:worka/phoenix/dashboard_work/filter.dart';
import 'package:worka/phoenix/dashboard_work/profile.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/SeeMore.dart';
import 'package:http/http.dart' as http;
import 'package:worka/redesigns/applicant/re_job_details_apply.dart';
import 'package:worka/redesigns/drawer/re_drawer_applicant.dart';
import 'package:worka/reuseables/general_container.dart';
import 'package:worka/screens/see_more/see_more.dart' as page;

import '../../phoenix/dashboard_work/interview/interviewScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.user}) : super(key: key);

  final UserModel? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffold = GlobalKey<ScaffoldState>();
  bool isFavorite = true;
  String name = '';
  String type = '';
  String searchText = '';
  final controller = RefreshController();
  final textController = TextEditingController();
  List<SeeMore> seeMore = [];
  bool moreJobLoading = true;

  @override
  void initState() {
    // context.read<Controller>().getMyJobs();
    context.read<Controller>().getHotAlert();
    context.read<Controller>().hotListJobs().then((v) => setState(() {
          seeMore = v;
          moreJobLoading = false;
        }));
    execute('').then((value) => setState(() {
          type = value;
        }));
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<String> execute(type) async {
    if (type == 'name') {
      return await context.read<Controller>().getUserDetails();
    }
    return await context.read<Controller>().getUserDetailsType();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<Controller>().homePage > 0) {
          context.read<Controller>().setHomePage(0);
          return false;
        }
        if (searchText.isNotEmpty) {
          setState(() {
            textController.clear();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: this.scaffold,
        drawer: ReDrawerApplicant(scaffold),
        body: SafeArea(
          child: SmartRefresher(
            controller: controller,
            onRefresh: () =>
                context.read<Controller>().seeMore(ctl: controller),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: CustomSearchForm(
                                    'Search for jobs or position',
                                    TextInputType.text,
                                    ctl: textController, onChange: (s) {
                                  setState(() {
                                    searchText = s;
                                  });
                                })),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () => Get.to(() => FilterPage()),
                              child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: DEFAULT_COLOR.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Icon(
                                    Icons.align_vertical_center_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: GestureDetector(
                              onTap: () => scaffold.currentState!.openDrawer(),
                              child: CircleAvatar(
                                maxRadius: 18.0,
                                backgroundColor: Color(0xff1B6DF9),
                                backgroundImage: NetworkImage(
                                    '${context.watch<Controller>().avatar}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            context.watch<Controller>().tags.length,
                            (i) => GeneralContainer(
                              name:
                                  '${context.watch<Controller>().tags[i].tag}',
                              onPress: () {
                                setState(() {
                                  textController.text =
                                      context.read<Controller>().tags[i].tag!;
                                });
                              },
                              paddingLeft: 20,
                              paddingTop: 14,
                              paddingRight: 0,
                              paddingBottom: 0,
                              width: 70,
                              height: 30,
                              size: 12,
                              bcolor: const Color(0xffFFFFFF),
                              stroke: 0,
                            ),
                          )
                        ],
                      ),
                    ),
                    textController.text.trim().isNotEmpty
                        ? Expanded(
                            child: context
                                    .watch<Controller>()
                                    .see
                                    .where((element) => element.title!
                                        .toLowerCase()
                                        .contains(
                                            textController.text.toLowerCase()))
                                    .map((e) => moreJobItems(e))
                                    .toList()
                                    .isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text('No Job Found',
                                                style: GoogleFonts.montserrat(
                                                  color: DEFAULT_COLOR,
                                                  fontSize: 18,
                                                )),
                                          ),
                                        )
                                      ])
                                : SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                        children: context
                                            .watch<Controller>()
                                            .see
                                            .where((element) => element.title!
                                                .toLowerCase()
                                                .contains(textController.text
                                                    .toLowerCase()))
                                            .map((e) => moreJobItems(e))
                                            .toList()),
                                  ))
                        : context.watch<Controller>().homePage <= 0
                            ? mainWidget()
                            : hostListingPage(),
                    const SizedBox(height: 1.0)
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainWidget() => Expanded(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 150, 0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Find the',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                        children: [
                          TextSpan(
                              text: ' Job',
                              style: GoogleFonts.montserrat(
                                  color: DEFAULT_COLOR,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1)),
                          TextSpan(
                              text: '\nyou dreamt of',
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1)),
                        ]),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
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
               moreJobLoading ? Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: SizedBox(
                  child: Center(child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(color: DEFAULT_COLOR))),
                 ),
               ) : Column(
                  children: [
                    seeMore.length > 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                child: Text(
                                  'Hot Listing',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              GeneralContainer(
                                name: 'See all',
                                onPress: () =>
                                    context.read<Controller>().setHomePage(1),
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
                          )
                        : Container(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        ...List.generate(seeMore.length,
                            (index) => hotListingMethod(seeMore[index])),
                      ]),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 10.0, 0, 0),
                  child: TextButton(
                      onPressed: null,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'More Jobs',
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
                ),
                moreJobsMethod(),
              ],
            ),
          ),
        ),
      );

  Widget hostListingPage() => Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 20),
                child: Text(
                  'Hot Listing',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: DEFAULT_COLOR,
                                    backgroundImage: NetworkImage(
                                        '${context.read<Controller>().see[index].employer_logo}'),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var key = context
                                            .read<Controller>()
                                            .see[index]
                                            .jobKey;
                                        if (context
                                            .read<Controller>()
                                            .see[index]
                                            .isLike) {
                                          context
                                              .read<Controller>()
                                              .see[index]
                                              .isLike = await disLike(key);
                                        } else {
                                          context
                                              .read<Controller>()
                                              .see[index]
                                              .isLike = await isLike(key);
                                        }
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        context
                                                .watch<Controller>()
                                                .see[index]
                                                .isLike
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 19,
                                        color: DEFAULT_COLOR,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${context.watch<Controller>().see[index].title}'
                                              .capitalizeFirst!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                          '${context.watch<Controller>().see[index].budget}/${context.watch<Controller>().see[index].salaryType}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  Flexible(
                                    child: AutoSizeText(
                                        '${context.watch<Controller>().see[index].location}',
                                        minFontSize: 10,
                                        maxFontSize: 18,
                                        maxLines: 1,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences storage =
                                          await SharedPreferences.getInstance();
                                      if (storage.getString(TYPE) ==
                                          'employee') {
                                        Get.to(() => JobDetailsScreen(
                                            '${context.read<Controller>().see[index].jobKey}'));
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(9.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          color: DEFAULT_COLOR),
                                      child: Text('Apply Now',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                      itemCount: context.watch<Controller>().see.length))
            ],
          ),
        ),
      );

  Padding hotListingMethod(SeeMore see) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(12.0),
        onTap: () async {
          if (context.read<Controller>().type == 'employee')
            Get.to(() => ReJobsDetails(see.jobKey!));
        },
        child: Container(
          width: 270.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: Colors.black54.withOpacity(.1), width: 1.4),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                            backgroundImage: NetworkImage(see.employer_logo!),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: Text(
                              '${see.title}',
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (see.isLike) {
                          see.isLike = await disLike(see.jobKey);
                        } else {
                          see.isLike = await isLike(see.jobKey);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        see.isLike ? Icons.bookmark : Icons.bookmark_outline,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    see.description!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: DEFAULT_COLOR_1.withOpacity(.8),
                                size: 17.0),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                see.location!,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.timelapse_outlined,
                                color: DEFAULT_COLOR_1.withOpacity(.8),
                                size: 17.0),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  see.jobType!,
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding moreJobItems(SeeMore see) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8.0),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(12.0),
        onTap: () async {
          Get.to(() => ReJobsDetails(see.jobKey!));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: DEFAULT_COLOR.withOpacity(.1),
                    offset: Offset(0.0, 4.0),
                    spreadRadius: 1.0,
                    blurRadius: 9.0)
              ]),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                            backgroundImage:
                                NetworkImage('${see.employer_logo}'),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Flexible(
                            child: Text(
                              '${see.title}',
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (see.isLike) {
                          see.isLike = await disLike(see.jobKey);
                        } else {
                          see.isLike = await isLike(see.jobKey);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        see.isLike ? Icons.bookmark : Icons.bookmark_outline,
                        size: 28.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    see.description!,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 15,
                        color: Colors.black87.withOpacity(.7),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: DEFAULT_COLOR_1.withOpacity(.8),
                                size: 17.0),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                '${see.location}',
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.timelapse_outlined,
                              color: DEFAULT_COLOR_1.withOpacity(.8),
                              size: 17.0),
                          const SizedBox(width: 10.0),
                          Text(
                            '${see.jobType}',
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding moreJobsMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 15, 0),
      child: Container(
        padding: EdgeInsets.only(
            top: context.watch<Controller>().see.isEmpty ? 100.0 : 0.0),
        child: context.watch<Controller>().see.isEmpty
            ? Center(
                child: Text(
                  'No Jobs Available',
                  style: GoogleFonts.montserrat(
                      fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                      context.watch<Controller>().see.length,
                      (index) =>
                          moreJobItems(context.watch<Controller>().see[index]))
                ],
              ),
      ),
    );
  }

  Widget carousel(HotAlert e) {
    return GestureDetector(
      onTap: () {
        if (e.link == 'profile') {
          Get.to(() => ProfileScreen());
        }
        if (e.link == 'interview') {
          Get.to(() => InterviewPage());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
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
  }

  Widget carouselEmpty() => GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
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
                onPressed: () {
                  Get.to(() => page.SeeMore());
                },
              )
            ],
          ),
        ),
      );

  // Widget listItem(ctx, SeeMore? see) => Container(
  //       width: MediaQuery.of(ctx).size.width,
  //       padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
  //       decoration: BoxDecoration(
  //         color: Colors.grey.withOpacity(.01),
  //         //borderRadius: BorderRadius.circular(10),
  //         // border: Border.all(color: DEFAULT_COLOR.withOpacity(.2)),
  //       ),
  //       margin: const EdgeInsets.symmetric(vertical: 0.0),
  //       child: InkWell(
  //         splashColor: Colors.blue.withOpacity(.1),
  //         borderRadius: BorderRadius.circular(7.0),
  //         onTap: () async {
  //           if (context.read<Controller>().type == 'employee')
  //             Get.to(() => JobDetailsScreen('${see!.jobKey}'));
  //         },
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4, 0.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Flexible(
  //                     child: AutoSizeText(
  //                       '${see!.title}'.capitalizeFirst!,
  //                       minFontSize: 12.0,
  //                       maxFontSize: 18.0,
  //                       maxLines: 1,
  //                       style: GoogleFonts.montserrat(
  //                           fontSize: 15, fontWeight: FontWeight.w600),
  //                     ),
  //                   ),
  //                   IconButton(
  //                     onPressed: () async {
  //                       if (see.isLike) {
  //                         see.isLike = await disLike(see.jobKey);
  //                       } else {
  //                         see.isLike = await isLike(see.jobKey);
  //                       }
  //                       setState(() {});
  //                     },
  //                     color: DEFAULT_COLOR,
  //                     icon: Icon(
  //                         see.isLike ? Icons.favorite : Icons.favorite_border),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 8.0),
  //               child: Container(
  //                 padding: const EdgeInsets.all(5.0),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(9.0),
  //                   color: Colors.blue.withOpacity(.1),
  //                 ),
  //                 child: Text(
  //                   '${see.currency!.toUpperCase()} ${see.budget}/${see.salaryType.toString().capitalizeFirst}',
  //                   style: GoogleFonts.montserrat(
  //                       color: Colors.black87,
  //                       fontSize: 12.5,
  //                       fontWeight: FontWeight.normal),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: ReadMoreText(
  //                 '${see.description}',
  //                 trimLines: 1,
  //                 colorClickableText: DEFAULT_COLOR,
  //                 trimMode: TrimMode.Line,
  //                 style: GoogleFonts.montserrat(
  //                   color: Colors.black,
  //                   fontSize: 12,
  //                 ),
  //                 trimCollapsedText: '\nShow more',
  //                 trimExpandedText: '\nShow less',
  //                 moreStyle: GoogleFonts.montserrat(
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.blue),
  //                 lessStyle: GoogleFonts.montserrat(
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.blue),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(8.0, 3, 0, 0),
  //                   child: Text(
  //                     '${see.jobType}',
  //                     style: GoogleFonts.montserrat(
  //                         fontSize: 13.5, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(8.0, 3, 8, 0),
  //                   child: '${see.isRemote}' == 'true'
  //                       ? Text(
  //                           'Remote,${see.location}',
  //                           maxLines: 1,
  //                           style: GoogleFonts.montserrat(
  //                               fontSize: 13,
  //                               color: Colors.grey,
  //                               fontWeight: FontWeight.normal),
  //                         )
  //                       : Text(
  //                           '${see.location}',
  //                           maxLines: 1,
  //                           style: GoogleFonts.montserrat(
  //                               fontSize: 13,
  //                               color: Colors.grey,
  //                               fontWeight: FontWeight.normal),
  //                         ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 10.0),
  //             Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 height: 1.0,
  //                 color: Colors.blueAccent.withOpacity(.3))
  //           ],
  //         ),
  //       ),
  //     );

  isLike(job_uid) async {
    try {
      final res = await http.Client().get(Uri.parse('${ROOT}like/$job_uid'),
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        return true;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
      return false;
    }
  }

  disLike(job_uid) async {
    try {
      final res = await http.Client().get(Uri.parse('${ROOT}dislike/$job_uid'),
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        return false;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
      return true;
    }
  }
}
