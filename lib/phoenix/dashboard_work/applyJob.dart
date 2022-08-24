import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/dashboard_work/applySubmit.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/JobDetails.dart';

class ApplyJob extends StatelessWidget {
  final JobData job;
  ApplyJob(this.job, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: DEFAULT_COLOR,
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Apply',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: DEFAULT_COLOR),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.transparent,
                    onPressed: null,
                  ),
                ),
              ]),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${job.title}',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 19, color: Colors.black),
                                  textAlign: TextAlign.start),
                              Text('Shell.com',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14, color: Colors.black26),
                                  textAlign: TextAlign.start),
                            ],
                          )),
                      SizedBox(height: 25.0),
                      CustomTextForm(
                          TextEditingController(
                              text:
                                  '${context.watch<Controller>().profileModel!.firstName}'),
                          '',
                          'First name',
                          TextInputType.text,
                          read: true),
                      SizedBox(height: 7.0),
                      CustomTextForm(
                          TextEditingController(
                              text:
                                  '${context.watch<Controller>().profileModel!.lastName}'),
                          '',
                          'Last name',
                          TextInputType.text,
                          read: true),
                      SizedBox(height: 7.0),
                      CustomTextForm(
                          TextEditingController(
                              text:
                                  '${context.watch<Controller>().profileModel!.otherName}'),
                          '',
                          'Other names',
                          TextInputType.text,
                          read: true),
                      SizedBox(height: 7.0),
                      CustomRichTextForm(
                          TextEditingController(
                              text:
                                  '${context.watch<Controller>().profileModel!.location}'),
                          '',
                          'Location',
                          TextInputType.text,
                          null),
                      SizedBox(height: 7.0),
                      CustomRichTextForm(
                          TextEditingController(
                              text:
                                  '${context.watch<Controller>().profileModel!.about}'),
                          '',
                          'About',
                          TextInputType.text,
                          null,
                          read: true),
                      SizedBox(height: 35.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: GeneralButtonContainer(
                          name: 'Continue',
                          color: DEFAULT_COLOR,
                          textColor: Colors.white,
                          onPress: () => Get.off(() => ApplySubmit(job)),
                          paddingBottom: 3,
                          paddingLeft: 30,
                          paddingRight: 30,
                          paddingTop: 5,
                        ),
                      ),
                      SizedBox(height: 35.0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
