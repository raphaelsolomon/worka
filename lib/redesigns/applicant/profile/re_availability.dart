import 'dart:io';
import 'package:worka/phoenix/model/ProfileModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignAvailability extends StatefulWidget {
  final bool edit;
  final Availability? update;
  final ProfileModel profileModel;
  const RedesignAvailability(this.profileModel,
      {super.key, required this.edit, this.update});

  @override
  State<RedesignAvailability> createState() => _RedesignAvailabilityState();
}

class _RedesignAvailabilityState extends State<RedesignAvailability> {
  bool isAvailable = true;

  bool isLoading = false;
  bool isUpdate = false;
  bool isDelete = false;

  @override
  void initState() {
    if (widget.edit) {
      isAvailable = widget.update!.fullTime!;
    }
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
                  Text('Availability',
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
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Choose Your Availaility',
                        style: GoogleFonts.lato(
                            fontSize: 15.0, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    getCardForm(
                        isAvailable, 'Available to work Fulltime or Parttime',
                        callBack: () {
                      setState(() {
                        isAvailable = true;
                      });
                    }),
                    const SizedBox(height: 20.0),
                    getCardForm(
                        isAvailable == false, 'Not Available to work Fulltime',
                        callBack: () {
                      setState(() {
                        isAvailable = false;
                      });
                    }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    widget.edit == false
                        ? isLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: DEFAULT_COLOR,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  var data = {
                                    'full_time': isAvailable,
                                    'part_time': isAvailable == false,
                                    'contract': false,
                                  };
                                  executeData(data);
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: DEFAULT_COLOR),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.lato(
                                            fontSize: 15.0, color: Colors.white),
                                      ),
                                    )),
                              )
                        : Column(
                            children: [
                              isUpdate
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: DEFAULT_COLOR,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: isDelete
                                          ? () {}
                                          : () async {
                                              var data = {
                                                'full_time': isAvailable,
                                                'part_time': isAvailable == false,
                                                'contract': false,
                                              };
                                              updateData(data);
                                            },
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(15.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: isDelete
                                                  ? Colors.grey.shade300
                                                  : DEFAULT_COLOR),
                                          child: Center(
                                            child: Text(
                                              'Update Availability',
                                              style: GoogleFonts.lato(
                                                  fontSize: 15.0,
                                                  color: isDelete
                                                      ? Colors.black87
                                                      : Colors.white),
                                            ),
                                          ))),
                              const SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: isUpdate
                                    ? () {}
                                    : () => delete(widget.update!.id),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete,
                                        color: isUpdate
                                            ? Colors.black45
                                            : Colors.redAccent),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      'Delete',
                                      style: GoogleFonts.lato(
                                          fontSize: 17.0, color: Colors.black54),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ))
          ],
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
      CustomSnack('Error', 'Unable to update availability');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void delete(id) async {
    setState(() {
      isDelete = true;
    });
    try {
      final res = await Dio().delete(
          '${ROOT}certificatedetails/${widget.update!.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Certification Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to delete availaility');
    } finally {
      setState(() {
        isDelete = false;
      });
    }
  }

  void updateData(Map data) async {
    setState(() {
      isUpdate = true;
    });
    try {
      final res = await Dio().post(
          '${ROOT}certificatedetails/${widget.update!.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Certification Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update availaility');
    } finally {
      setState(() {
        isUpdate = false;
      });
    }
  }

  getCardForm(bool b, text, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () => callBack(),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: b ? DEFAULT_COLOR : Colors.black54, width: 1.5),
                color: DEFAULT_COLOR.withOpacity(.02)),
            child: Row(children: [
              Icon(
                Icons.shield_outlined,
                color: b ? DEFAULT_COLOR : Colors.black45,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Text('$text',
                    style: GoogleFonts.lato(
                        fontSize: 15.0,
                        color: b ? DEFAULT_COLOR : Colors.black54)),
              )
            ])),
      ),
    );
  }
}
