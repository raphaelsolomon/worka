import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';
import 'package:worka/screens/main_screens/main_nav.dart';

class ReApplyJob extends StatefulWidget {
  final String jobKey;
  const ReApplyJob(this.jobKey, {super.key});

  @override
  State<ReApplyJob> createState() => _ReApplyJobState();
}

class _ReApplyJobState extends State<ReApplyJob> {
  bool isLoading = false;
  bool pageLoading = true;
  bool isUpload = false;
  ProfileModel? profileModel = null;
  final refresh = RefreshController();
  final coverLetter = TextEditingController();
  final jobReqirement = TextEditingController();
  final email = TextEditingController();
  final fname = TextEditingController();
  final lastname = TextEditingController();
  File path = File('');
  String size = '0.00kb';

  _fetchProfile() async {
    return await context.read<Controller>().getprofileReview();
  }

  @override
  void initState() {
    _fetchProfile().then((value) => setState(() {
          profileModel = value;
          pageLoading = false;
          lastname.text = profileModel!.lastName!;
          fname.text = profileModel!.firstName!;
          email.text = profileModel!.user!.email!;
          coverLetter.text = profileModel!.profileSummary!;
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
            height: 10.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: DEFAULT_COLOR,
                  )),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                'Apply Job',
                style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
              )
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          Expanded(
              child: pageLoading
                  ? Center(
                      child: CircularProgressIndicator(color: DEFAULT_COLOR))
                  : SmartRefresher(
                      controller: refresh,
                      header: WaterDropHeader(),
                      onRefresh: () =>
                          _fetchProfile().then((value) => setState(() {
                                profileModel = value;
                                refresh.refreshCompleted();
                              })),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              inputWidget(
                                  text: 'First name',
                                  icons: Icons.shopping_basket,
                                  hint: 'First name',
                                  ctl: fname),
                              const SizedBox(
                                height: 25.0,
                              ),
                              inputWidget(
                                  text: 'Last name',
                                  icons: Icons.shopping_basket,
                                  hint: 'Last name',
                                  ctl: lastname),
                              const SizedBox(
                                height: 25.0,
                              ),
                              inputWidget(
                                  text: 'E-mail Address',
                                  icons: Icons.school_outlined,
                                  hint: 'E-mail Address',
                                  ctl: email),
                              const SizedBox(
                                height: 25.0,
                              ),
                              inputWidgetRich(
                                  text: 'Add Cover Letter',
                                  icons: Icons.school_outlined,
                                  hint: 'Cover letter',
                                  ctl: coverLetter),
                              const SizedBox(
                                height: 25.0,
                              ),
                              isUpload
                                  ? GestureDetector(
                                      onTap: () async {
                                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null) {
                            path = File(result.files.single.path!);
                            size = await getFileSize(path.path, 1);
                          setState(() {});
                        } else {
                          // User canceled the picker
                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.redAccent
                                                .withOpacity(.1)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.file_open,
                                              color: Colors.redAccent,
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${p.basename(profileModel!.cv!)}',
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black54,
                                                        fontSize: 15.0),
                                                  ),
                                                  Text(
                                                    '',
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black54,
                                                        fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.redAccent,
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : inputWidgetCV(),
                              const SizedBox(
                                height: 40.0,
                              ),
                              isLoading
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                              color: DEFAULT_COLOR)))
                                  : GestureDetector(
                                      onTap: () async {
                                        executeData(widget.jobKey);
                                      },
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: DEFAULT_COLOR),
                                          child: Center(
                                            child: Text(
                                              'Submit',
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
                    ))
        ],
      )),
    );
  }

  executeData(job_uid) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await Dio().post('${ROOT}applyjob/',
          data: {'jobid': '$job_uid'},
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        if (res.data == 'successfully applied') {
          return showpopUp();
        }
      } else {
        return CustomSnack('Error', '${res.data}');
      }
    } on SocketException {
      CustomSnack('Error', 'Check internet Connection');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showpopUp() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 400.0,
                  margin: const EdgeInsets.all(
                      40), // to push the box half way below circle
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, right: 20), // spacing inside the box
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Image.asset(
                          'assets/success.png',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text('Congratulations!',
                            style: GoogleFonts.lato(
                                fontSize: 17.0,
                                color: Color(0xFF00D0BC),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'You Job Application has be submitted successfully.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 13.0, color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'A ',
                              style: GoogleFonts.lato(
                                  fontSize: 13.0, color: Colors.black45),
                            ),
                            Text('Notification',
                                style: GoogleFonts.lato(
                                    fontSize: 13.0,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.w600)),
                            Flexible(
                                child: Text(
                                    ' will be sent to track your progress.',
                                    style: GoogleFonts.lato(
                                        fontSize: 13.0, color: Colors.black45)))
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )).whenComplete(() => Get.offAll(() => MainNav()));
  }

  Widget inputWidget({text = '', icons = Icons.person, hint = '', ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.03),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            controller: ctl,
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                hintText: '$hint',
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }

  Widget inputWidgetCV() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'Upload your Resume/CV',
                style: GoogleFonts.lato(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 50.0,
            ),
            Flexible(
              child: Text(
                'Pdf, Doc, Jpeg, Png ( Max 10mb)',
                style: GoogleFonts.lato(
                    fontSize: 13.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        DottedBorder(
          dashPattern: [8, 4],
          strokeWidth: 2,
          padding: EdgeInsets.all(6),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(children: [
              Icon(
                Icons.file_open_outlined,
                color: DEFAULT_COLOR,
                size: 18.0,
              ),
              const SizedBox(width: 20.0),
              Flexible(
                  child: Text('Browse files to upload',
                      style: GoogleFonts.lato(
                          fontSize: 13.0, color: Colors.black54)))
            ]),
          ),
        ),
      ],
    );
  }

  Widget inputWidgetRich(
      {text = 'Job Description', icons = Icons.edit, hint = 'Type here', ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          height: 180.0,
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.03),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            controller: ctl,
            maxLines: null,
            maxLength: 500,
            keyboardType: TextInputType.multiline,
            style: GoogleFonts.lato(fontSize: 16.0, color: Colors.black54),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                hintText: '$hint',
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }

   getFileSize(String filepath, int decimals) {
    var file = File(filepath);
    return file.length().then((bytes) {
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1024)).floor();
      return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
          ' ' +
          suffixes[i];
    });
  }
}
