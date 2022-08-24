import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../Success.dart';

class AddAvailablity extends StatefulWidget {
  @override
  State<AddAvailablity> createState() => _AddAvailablityState();
}

class _AddAvailablityState extends State<AddAvailablity> {
  bool isLoading = false;

  bool fulltime = false;

  bool part_time = false;

  bool contract = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: DEFAULT_COLOR,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text('Add Availability',
                    style: GoogleFonts.lato(fontSize: 18, color: Colors.blue),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.black,
                    onPressed: null,
                  ),
                )
              ]),
              const SizedBox(height: 8.0),
              imageView('${context.watch<Controller>().avatar}'),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Availablity',
                    style: GoogleFonts.lato(
                        fontSize: 14.0,
                        color: DEFAULT_COLOR,
                        decoration: TextDecoration.none)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                      value: fulltime,
                      onChanged: (b) {
                        setState(() {
                          fulltime = b!;
                        });
                      }),
                  SizedBox(width: 10.0),
                  AutoSizeText(
                    'FullTime',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                    minFontSize: 11,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                      value: part_time,
                      onChanged: (b) {
                        setState(() {
                          part_time = b!;
                        });
                      }),
                  SizedBox(width: 10.0),
                  AutoSizeText(
                    'Part-time',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                    minFontSize: 11,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                      value: contract,
                      onChanged: (b) {
                        setState(() {
                          contract = b!;
                        });
                      }),
                  SizedBox(width: 10.0),
                  AutoSizeText(
                    'Contract',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                    minFontSize: 11,
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GeneralButtonContainer(
                            name: 'Add Availability',
                            color: Color(0xff0D30D9),
                            textColor: Colors.white,
                            onPress: () {
                              setState(() {
                                isLoading = true;
                              });
                              var data = {
                                'full_time': fulltime,
                                'part_time': part_time,
                                'contract': contract,
                              };
                              executeData(data);
                            },
                            paddingBottom: 3,
                            paddingLeft: 30,
                            paddingRight: 30,
                            paddingTop: 5,
                          ),
                  )),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void executeData(Map data) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await Dio().post('${ROOT}addavailability/',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Availability added...',
              callBack: () => Get.back(),
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
      context.read<Controller>().getprofileReview();
    }
  }
}
