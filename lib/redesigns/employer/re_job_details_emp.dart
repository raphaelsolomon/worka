import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/employer_page/phoenix/screens/applications.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:worka/redesigns/employer/re_company_profile.dart';
import 'package:worka/redesigns/employer/redesign_editpost.dart';

class ReJobsDetails extends StatefulWidget {
  final MyPosted jobs;
  const ReJobsDetails(this.jobs, {super.key});

  @override
  State<ReJobsDetails> createState() => _ReJobsDetailsState();
}

class _ReJobsDetailsState extends State<ReJobsDetails> {
  bool isJobDesc = true;
  final refresh = RefreshController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          Icon(Icons.keyboard_backspace, color: DEFAULT_COLOR)),
                  Visibility(
                    visible: false,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: .5, color: Colors.black54)),
                      child: Icon(
                        Icons.bookmark_outline,
                        color: Colors.black54,
                        size: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border:
                                Border.all(width: .5, color: Colors.black54)),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: DEFAULT_COLOR.withOpacity(.1),
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  '${context.watch<Controller>().avatar}'),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            FittedBox(
                              child: Text(
                                '${widget.jobs.title}'.capitalize!,
                                style: GoogleFonts.lato(
                                    fontSize: 19.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      '${widget.jobs.location}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: DEFAULT_COLOR.withOpacity(.1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      '${widget.jobs.jobType}'.capitalize!,
                                      style: GoogleFonts.lato(
                                          fontSize: 13.0,
                                          color: DEFAULT_COLOR,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: Colors.black54,
                              thickness: .5,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.jobs.categories!,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '${widget.jobs.budget} ${widget.jobs.salary_type}',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      color: DEFAULT_COLOR,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: GestureDetector(
                            onTap: () => setState(() => isJobDesc = true),
                            child: Column(
                              children: [
                                Text(
                                  'Job Description',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: isJobDesc
                                          ? DEFAULT_COLOR
                                          : Colors.black54),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Divider(
                                    thickness: isJobDesc ? 5.0 : 2.0,
                                    color: isJobDesc
                                        ? DEFAULT_COLOR
                                        : Colors.black26,
                                  ),
                                )
                              ],
                            ),
                          )),
                          Flexible(
                              child: GestureDetector(
                            onTap: () {
                              Get.to(() => ReCompanyProfile());
                            },
                            child: Column(
                              children: [
                                Text(
                                  'About Company',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: !isJobDesc
                                          ? DEFAULT_COLOR
                                          : Colors.black54),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Divider(
                                  thickness: !isJobDesc ? 5.0 : 2.0,
                                  color: !isJobDesc
                                      ? DEFAULT_COLOR
                                      : Colors.black26,
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      isJobDesc
                          ? getJobDescription(widget.jobs)
                          : const SizedBox(),
                      const SizedBox(
                        height: 25.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Applications(
                              widget.jobs.jobKey!, widget.jobs.title!,
                              extra: widget.jobs));
                          context
                              .read<Controller>()
                              .setCompanyPage('description');
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: DEFAULT_COLOR),
                            child: Center(
                              child: Text(
                                'View Applications List',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ReEditPostedJob(widget.jobs));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: DEFAULT_COLOR),
                            child: Center(
                              child: Text(
                                'Edit Job Details',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      isLoading
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: DEFAULT_COLOR,
                              )))
                          : GestureDetector(
                              onTap: () => execute(context),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.redAccent),
                                  child: Center(
                                    child: Text(
                                      'Close Vacancy',
                                      style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                      const SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void execute(BuildContext c) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await http.Client().get(
          Uri.parse('${ROOT}close_job/${widget.jobs.jobKey}'),
          headers: {'Authorization': 'TOKEN ${c.read<Controller>().token}'});
      if (res.statusCode == 200) {
        Get.off(
          () => Success(
            
            'Job Closed Successfully..',
            callBack: () {
              Get.offAll(() => EmployerNav());
            },
          ),
        );
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection...');
    } on Exception {
      CustomSnack('Error', 'Unable to send request..');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

Widget getJobDescription(MyPosted jobs) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Job Description:',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobs.description}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Requirements:',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobs.requirement}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Qualification:',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobs.qualification}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Benefits:',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      ...List.generate(jobs.benefit.toString().split(', ').length, (i) {
        return Row(
          children: [
            Icon(
              Icons.shield_outlined,
              color: DEFAULT_COLOR,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text('${jobs.benefit.toString().split(', ')[i]}',
                  style:
                      GoogleFonts.lato(fontSize: 16.0, color: Colors.black54)),
            )
          ],
        );
      }),
      const SizedBox(
        height: 18.0,
      ),
      Text('Required Skills:',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Wrap(spacing: 12.0, children: [
        ...List.generate(
            0,
            (i) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                    color: DEFAULT_COLOR.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: .5, color: DEFAULT_COLOR)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Production',
                        style: GoogleFonts.lato(
                            fontSize: 15.0, color: DEFAULT_COLOR)),
                    const SizedBox(width: 15.0),
                    Text('x',
                        style: GoogleFonts.lato(
                            fontSize: 16.0, color: DEFAULT_COLOR)),
                  ],
                ))),
      ])
    ]);
