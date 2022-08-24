import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/phoenix/screens/ViewSubmitted.dart';
import 'package:worka/models/EmpIntModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../../phoenix/dashboard_work/preview.dart';

class EmpInterview extends StatefulWidget {
  EmpInterview({Key? key}) : super(key: key);

  @override
  State<EmpInterview> createState() => _EmpInterviewState();
}

class _EmpInterviewState extends State<EmpInterview> {
  List<EmpIntModel> empIntModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text('Interviews',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Color(0xff0D30D9)),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Color(0xff0D30D9),
                    onPressed: null,
                  ),
                ),
              ]),
              const SizedBox(height: 8.0),
              FutureBuilder(
                future: request(context),
                builder: (ctx, snapshot) => _container(snapshot),
              ),
              const SizedBox(height: 30.0),
            ])));
  }

  Widget listItem(BuildContext context, EmpIntModel j) => InkWell(
        onTap: () {
          if (j.questioned == true) {
            Get.to(() => ViewSubmitted(j.interviewUid));
          } else {
            Get.to(() => Screens(interviewStep7(
                context, j.interviewUid, j.note,
                type: j.interviewType)));
          }
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: DEFAULT_COLOR.withOpacity(.06),
                  offset: Offset.zero,
                  blurRadius: 3,
                  spreadRadius: 3),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                            radius: 17,
                            backgroundImage:
                                NetworkImage('${j.job.employerLogo}'),
                            backgroundColor: Colors.blue),
                      ),
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: '${j.title}'.capitalizeFirst,
                            style: GoogleFonts.montserrat(
                                color: DEFAULT_COLOR.withOpacity(.5)),
                            children: [
                              TextSpan(
                                  text: ' for ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14, color: Colors.grey)),
                              TextSpan(
                                  text: '${j.job.title}'.capitalizeFirst,
                                  style: GoogleFonts.montserrat(
                                      color: DEFAULT_COLOR.withOpacity(.5))),
                              TextSpan(
                                  text: ' created on ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14, color: Colors.grey)),
                              TextSpan(
                                  text:
                                      '${DateFormat('yyyy-MM-dd').format(j.startDate)} ',
                                  style: GoogleFonts.montserrat(
                                      color: DEFAULT_COLOR.withOpacity(.5))),
                              TextSpan(
                                  text: ' and to be closed on ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14, color: Colors.grey)),
                              TextSpan(
                                  text:
                                      '${DateFormat('yyyy-MM-dd').format(j.endDate)}.',
                                  style: GoogleFonts.montserrat(
                                      color: DEFAULT_COLOR.withOpacity(.5))),
                            ],
                          ),
                          minFontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ),
                      Container()
                    ]),
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: 'type: ',
                            style: GoogleFonts.montserrat(),
                            children: [
                              TextSpan(
                                  text: '${j.interviewType}',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: j.status == 'open'
                                          ? Colors.green[300]
                                          : Colors.red[300])),
                            ],
                          ),
                          minFontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ),
                      j.timer == true
                          ? Flexible(
                              flex: j.timer == true ? 1 : 0,
                              child: AutoSizeText.rich(
                                TextSpan(
                                  text: 'duration: ',
                                  style: GoogleFonts.montserrat(),
                                  children: [
                                    TextSpan(
                                        text: '${j.timerSec} mins',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400,
                                            color: j.status == 'open'
                                                ? Colors.green[300]
                                                : Colors.red[300])),
                                  ],
                                ),
                                minFontSize: 11,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45),
                              ),
                            )
                          : Container(),
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: 'status: ',
                            style: GoogleFonts.montserrat(),
                            children: [
                              TextSpan(
                                  text: '${j.status}',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: j.status == 'open'
                                          ? Colors.green[300]
                                          : Colors.red[300])),
                            ],
                          ),
                          minFontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ),
                    ]),
              ],
            )),
      );

  Widget _container(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        List<EmpIntModel> j = snapshot.data;
        print(j.length);
        if (j.isNotEmpty) {
          return Expanded(
              child: ListView.builder(
                  itemCount: j.length,
                  itemBuilder: (ctx, i) => listItem(ctx, j[i])));
        } else {
          return Expanded(
            child: Center(
                child: Text('No Interview created.',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)))),
          );
        }
      } else {
        return Expanded(child: Center(child: const Text('Empty data')));
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Future<List<EmpIntModel>> request(BuildContext c) async {
    try {
      final res = await Dio().get('${ROOT}interview/view_posted_interviews/',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        empIntModel = res.data
            .map<EmpIntModel>((json) => EmpIntModel.fromMap(json))
            .toList();
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
    }
    return empIntModel;
  }
}
