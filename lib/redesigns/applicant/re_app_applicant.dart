import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/MyJobsModel.dart';
import 'package:worka/redesigns/applicant/re_app_progress.dart';

class ReApplicationApplicant extends StatefulWidget {
  const ReApplicationApplicant({super.key});

  @override
  State<ReApplicationApplicant> createState() => _ReApplicationApplicantState();
}

class _ReApplicationApplicantState extends State<ReApplicationApplicant> {
  bool isLoading = true;
  List<MyJobsModel> myJobsModel = [];
  final controller = RefreshController();

  @override
  void initState() {
    context.read<Controller>().getMyJobs().then((v) => setState(() {
          myJobsModel = v;
          isLoading = false;
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
                  Text('Applications',
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
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: DEFAULT_COLOR))
                    : SmartRefresher(
                        controller: controller,
                        header: WaterDropHeader(),
                        onRefresh: () => context
                            .read<Controller>()
                            .getMyJobs()
                            .then((v) => setState(() {
                                  myJobsModel = v;
                                  controller.refreshCompleted();
                                })),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...List.generate(
                                  myJobsModel.length,
                                  (i) => GestureDetector(
                                        onTap: () =>
                                            Get.to(() => ReAppProgress(myJobsModel[i])),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(10.0),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                                  border: Border.all(width: 1.0, color: Colors.black12),
                                              color: Colors.white,
                                              ),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage('${myJobsModel[i].job.employer.companyLogo}'),
                                                  radius: 30.0,
                                                  backgroundColor: DEFAULT_COLOR
                                                      .withOpacity(.08),
                                                ),
                                                const SizedBox(width: 20.0),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('${myJobsModel[i].job.employer.companyName}',
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .black54, fontWeight: FontWeight.w400)),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Text('${myJobsModel[i].job.title}',
                                                          style: GoogleFonts.lato(
                                                              fontSize: 19.0,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0,
                                                                  vertical:
                                                                      4.0),
                                                          margin: const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 4.0),
                                                          decoration: BoxDecoration(
                                                              color: DEFAULT_COLOR
                                                                  .withOpacity(
                                                                      .2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              border: Border.all(
                                                                  width: .5,
                                                                  color:
                                                                      DEFAULT_COLOR)),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                  'Application Sent',
                                                                  style: GoogleFonts.lato(
                                                                      fontSize:
                                                                          15.0,
                                                                      color:
                                                                          DEFAULT_COLOR, fontWeight: FontWeight.w500)),
                                                            ],
                                                          )),
                                                          const SizedBox(
                                                          height: 5.0),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
