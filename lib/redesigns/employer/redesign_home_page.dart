import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/phoenix/screens/JobDetails.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/drawer/re_drawer.dart';
import 'package:worka/redesigns/employer/reViewApplicants.dart';
import 'package:worka/redesigns/employer/redesign_post_job.dart';

class ReHomePage extends StatefulWidget {
  const ReHomePage({super.key});

  @override
  State<ReHomePage> createState() => _ReHomePageState();
}

class _ReHomePageState extends State<ReHomePage> {
  final scaffold = GlobalKey<ScaffoldState>();
  int counter = 0;
  final controller = RefreshController();
  List<MyPosted> postedJobs = [];
  bool isLoading = true;
  bool isprofileLoading = true;
  CompModel? compModel = null;

  fetchData(BuildContext context) async {
    return await context.read<EmpController>().getPostedJobs(context);
  }

  fetchProfile(BuildContext context) async {
    return await context.read<EmpController>().getEmployerDetails(context);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchData(context).then((value) => setState(() {
            postedJobs = value;
            isLoading = false;
          }));

      fetchProfile(context).then((value) {
        setState(() {
          compModel = value;
          isprofileLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      drawer: ReDrawer(scaffold),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => scaffold.currentState!.openDrawer(),
                      child: Icon(
                        Icons.menu,
                        color: DEFAULT_COLOR,
                      )),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.notification_important_outlined,
                            color: DEFAULT_COLOR,
                          )),
                      const SizedBox(width: 15.0),
                      CircleAvatar(
                        backgroundColor: DEFAULT_COLOR.withOpacity(.1),
                        radius: 28,
                        backgroundImage: NetworkImage(
                            '${context.watch<Controller>().avatar}'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'Jobs Posted',
                        style: GoogleFonts.lato(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => RePostJobs());
                    },
                    child: Text(
                      'Post a Job',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: DEFAULT_COLOR,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: DEFAULT_COLOR))
                    : isprofileLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: DEFAULT_COLOR))
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: SmartRefresher(
                              controller: controller,
                              onRefresh: () => fetchData(context)
                                  .then((value) => setState(() {
                                        postedJobs = value;
                                        controller.refreshCompleted();
                                      })),
                              child: postedJobs.isEmpty
                                  ? _isEmpty()
                                  : SingleChildScrollView(
                                      child: Column(children: [
                                      const SizedBox(
                                        height: 25.0,
                                      ),
                                      ...List.generate(
                                        postedJobs.length,
                                        (i) => InkWell(
                                          onTap: () => Get.to(() => JobDetailsEmp(postedJobs[i])),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 15.0),
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                    width: 1.5,
                                                    color: '${postedJobs[i].access}' == 'open' ? DEFAULT_COLOR.withOpacity(.8) : Colors.transparent)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          DEFAULT_COLOR
                                                              .withOpacity(.03),
                                                      radius: 28.0,
                                                      backgroundImage: NetworkImage(
                                                          '${context.watch<Controller>().avatar}'),
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${compModel!.companyName}',
                                                            style:
                                                                GoogleFonts.lato(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 2.0,
                                                          ),
                                                          Text(
                                                            '${compModel!.companyEmail}',
                                                            style:
                                                                GoogleFonts.lato(
                                                                    fontSize:
                                                                        13.0,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                  '${postedJobs[i].title}'
                                                      .capitalize!,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 6.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.location_on,
                                                              size: 17.0,
                                                              color:
                                                                  Colors.black26),
                                                          Text(
                                                            '${compModel!.location}',
                                                            style:
                                                                GoogleFonts.lato(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
                                                              color:
                                                                  Colors.green),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5.0),
                                                          color: Colors.green
                                                              .withOpacity(.1)),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 2.5),
                                                      child: Text(
                                                        '${postedJobs[i].access}',
                                                        style: GoogleFonts.lato(
                                                            fontSize: 12.5,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${postedJobs[i].applications} Applicants',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                    ),
                                                    InkWell(
                                                      onTap: () => Get.to(() =>
                                                          ReViewApplicant(postedJobs[i], compModel!)),
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
                                    ])),
                            )))
          ],
        ),
      ),
    );
  }
}

Widget bottomNavItem({icons = Icons.home_outlined, text = 'Home', isActive}) =>
    Column(children: [
      Icon(
        icons,
        size: 26.0,
        color: isActive ? DEFAULT_COLOR : Colors.black54,
      ),
      const SizedBox(height: 3.0),
      Text(
        '$text',
        style: GoogleFonts.lato(
            fontSize: 14.0, color: isActive ? DEFAULT_COLOR : Colors.black54),
      )
    ]);

Widget _isEmpty() => Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text('Empty State',
              style: GoogleFonts.lato(fontSize: 19.0, color: Colors.black54)),
          const SizedBox(height: 20.0),
          Text('You don\'t have any Posted Jobs Yet.',
              style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
        ]));
