import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/employer_page/phoenix/screens/editPostedJobs.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import '../../../phoenix/model/Constant.dart';
import 'applications.dart';
import 'package:http/http.dart' as http;

class JobDetailsEmp extends StatefulWidget {
  final MyPosted job;
  JobDetailsEmp(this.job, {Key? key}) : super(key: key);

  @override
  State<JobDetailsEmp> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetailsEmp> {
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            color: Color(0xff0D30D9),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Text('Job Description',
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
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Image(
                            image: NetworkImage(
                                '${context.watch<Controller>().avatar}'),
                            width: 100,
                            height: 100),
                        SizedBox(height: 30.0),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(widget.job.title!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 19,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(widget.job.location!,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14, color: Colors.grey),
                                    textAlign: TextAlign.left),
                                SizedBox(height: 10.0),
                                Container(
                                  height: 30.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0D30D9).withOpacity(.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<Controller>()
                                                .setCompanyPage('description');
                                          },
                                          child: Container(
                                            height: 30.0,
                                            decoration: context
                                                        .watch<Controller>()
                                                        .companyPage ==
                                                    'description'
                                                ? BoxDecoration(
                                                    color: Color(0xFF1B6DF9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )
                                                : BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                            child: Center(
                                              child: Text('Job Requirements',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      color: context
                                                                  .watch<
                                                                      Controller>()
                                                                  .companyPage ==
                                                              'description'
                                                          ? Colors.white
                                                          : Colors.black87),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<Controller>()
                                                .setCompanyPage('about');
                                          },
                                          child: Container(
                                            height: 30.0,
                                            decoration: context
                                                        .watch<Controller>()
                                                        .companyPage ==
                                                    'about'
                                                ? BoxDecoration(
                                                    color: Color(0xFF1B6DF9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )
                                                : BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                            child: Center(
                                              child: Text('Job Details',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      color: context
                                                                  .watch<
                                                                      Controller>()
                                                                  .companyPage ==
                                                              'about'
                                                          ? Colors.white
                                                          : Colors.black87),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                context.watch<Controller>().companyPage ==
                                        'about'
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Text('Job Description',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center),
                                            ),
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Text(
                                                  widget.job.description!,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      height: 1.5,
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.justify),
                                            ),
                                            SizedBox(
                                              height: 30.0,
                                            )
                                          ],
                                        ))
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10.0),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text(
                                                          'Requirements:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 11.0),
                                                            child: AutoSizeText(
                                                                '${widget.job.requirement}',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .grey),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text(
                                                          'Qualification:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 11.0),
                                                            child: AutoSizeText(
                                                                '${widget.job.qualification} ',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .grey),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text('Job Type:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 11.0),
                                                          child: Text(
                                                              widget.job.isRemote ==
                                                                      true
                                                                  ? 'Remote'
                                                                  : 'Full-Time',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text('Category:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 11.0),
                                                          child: Text(
                                                              ' ${widget.job.categories}',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                        ),
                                                      ],
                                                    ),
                                                    //==================================================
                                                    SizedBox(height: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text('Salary:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 11.0),
                                                          child: Text(
                                                              '${widget.job.currency!.toUpperCase()} ${widget.job.budget}/${widget.job.salary_type}',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey),
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text('Benefits:',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            color: Color(
                                                                0xff0D30D9),
                                                            size: 6),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 11.0),
                                                            child: Text(
                                                                '${widget.job.benefit ?? ''}',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .grey),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(height: 30.0),
                                          ],
                                        )),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: GeneralButtonContainer(
                                    name: 'View Applications List',
                                    color: Color(0xff0D30D9),
                                    textColor: Colors.white,
                                    onPress: () {
                                      Get.to(() => Applications(
                                          widget.job.jobKey!, widget.job.title!,
                                          extra: widget.job));
                                      context
                                          .read<Controller>()
                                          .setCompanyPage('description');
                                    },
                                    paddingBottom: 3,
                                    paddingLeft: 10,
                                    paddingRight: 10,
                                    paddingTop: 5,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: GeneralButtonContainer(
                                    name: 'Edit Job',
                                    color: Color(0xff0D30D9),
                                    textColor: Colors.white,
                                    onPress: () {
                                      Get.to(() => EditPostJob(widget.job));
                                    },
                                    paddingBottom: 3,
                                    paddingLeft: 10,
                                    paddingRight: 10,
                                    paddingTop: 5,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : GeneralButtonContainer(
                                          name: 'Close Vacancy',
                                          color: Colors.redAccent,
                                          textColor: Colors.white,
                                          onPress: () {
                                            execute(context);
                                          },
                                          paddingBottom: 3,
                                          paddingLeft: 10,
                                          paddingRight: 10,
                                          paddingTop: 5,
                                        ),
                                ),
                                SizedBox(height: 30.0),
                              ],
                            )),
                      ]))
                ],
              ),
            ),
          ),
        ));
  }

  void execute(BuildContext c) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await http.Client().get(
          Uri.parse('${ROOT}close_job/${widget.job.jobKey}'),
          headers: {'Authorization': c.read<Controller>().token});
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
