import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';

class PostJobPreview extends StatefulWidget {
  const PostJobPreview({Key? key}) : super(key: key);

  @override
  State<PostJobPreview> createState() => _PostJobPreviewState();
}

class _PostJobPreviewState extends State<PostJobPreview> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () => Get.back(),
              ),
            ),
            Text('Company profile',
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
                Image(image: NetworkImage(''), width: 100, height: 100),
                SizedBox(height: 30.0),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('UI/UI Designer',
                                style: GoogleFonts.montserrat(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(height: 5.0),
                          Text('Lagos, Nigeria',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.left),
                          SizedBox(height: 20.0),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text('Job Description',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12, color: Colors.black),
                                        textAlign: TextAlign.center),
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: FittedBox(
                                      child: AutoSizeText(COMPANY_DESC,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                          textAlign: TextAlign.start),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue.withOpacity(.2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text('Requirements:',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center),
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .panorama_fisheye_outlined,
                                                  color: Color(0xff0D30D9),
                                                  size: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11.0),
                                                child: Text(
                                                    '2-3 years of experience as a UI/UX designer Experience',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .panorama_fisheye_outlined,
                                                    color: Color(0xff0D30D9),
                                                    size: 6),
                                                SizedBox(
                                                  width: 11,
                                                ),
                                                Flexible(
                                                  child: AutoSizeText(
                                                    'Understanding of Grids, Brand guide and Design system and good eye for design.',
                                                    maxLines: 30,
                                                    minFontSize: 11,
                                                    maxFontSize: 18,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //==================================================
                                          SizedBox(height: 20.0),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text('Benefits:',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center),
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .panorama_fisheye_outlined,
                                                  color: Color(0xff0D30D9),
                                                  size: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11.0),
                                                child: Text(
                                                    '#250k-400 monthly.',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .panorama_fisheye_outlined,
                                                  color: Color(0xff0D30D9),
                                                  size: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11.0),
                                                child: Text(
                                                    'Access to Design Resources.',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .panorama_fisheye_outlined,
                                                  color: Color(0xff0D30D9),
                                                  size: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11.0),
                                                child: Text('Free Seminars',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(height: 50.0),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : GeneralButtonContainer(
                                            name: 'Post Job',
                                            color: Color(0xff0D30D9),
                                            textColor: Colors.white,
                                            onPress: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                            },
                                            paddingBottom: 3,
                                            paddingLeft: 30,
                                            paddingRight: 30,
                                            paddingTop: 5,
                                          ),
                                  ),
                                  SizedBox(height: 30.0),
                                ],
                              )),
                        ]))
              ],
            ),
          )
        ]),
      )),
    );
  }

  void executeData(Map data) async {
    try {
      final res = await Dio().post('${ROOT}url/',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        print(res.data);
        CustomSnack('Success', 'Job posted successfully...');
        Get.to(() => Success(
              'Job posted successfully...',
              imageAsset: 'assets/assets/succ.png',
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update laguage');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
