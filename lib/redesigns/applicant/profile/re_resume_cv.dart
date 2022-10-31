import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignResume extends StatefulWidget {
   final bool isEdit;
  final String? eModel;
  const RedesignResume({super.key,  required this.isEdit, this.eModel});

  @override
  State<RedesignResume> createState() => _RedesignResumeState();
}

class _RedesignResumeState extends State<RedesignResume> {
  bool isAvailable = true;
  File path = File('');

  @override
  void initState() {
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
                  Text('Resume/CV',
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
                    Text(
                      'Upload Your Resume/CV',
                      style:
                          GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null) {
                          setState(() {
                            path = File(result.files.single.path!);
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: DottedBorder(
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        padding: EdgeInsets.all(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_open_outlined,
                                  color: DEFAULT_COLOR_1,
                                ),
                                const SizedBox(width: 20.0),
                                Flexible(
                                    child: Text('Browse files to upload',
                                        style: GoogleFonts.lato(
                                            fontSize: 13.0,
                                            color: Colors.black54)))
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Uploaded Files',
                      style:
                          GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: DEFAULT_COLOR_1.withOpacity(.1)),
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
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${p.basename(path.path)}',
                                  style: GoogleFonts.lato(
                                      color: Colors.black54, fontSize: 15.0),
                                ),
                                Text(
                                  path.path == ''
                                      ? '0.00 byte'
                                      : '${getFileSize(path.path, 1)}',
                                  style: GoogleFonts.lato(
                                      color: Colors.black54, fontSize: 12.0),
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
                    const SizedBox(
                      height: 30.0,
                    ),
                    context.watch<Controller>().cvLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: DEFAULT_COLOR)),
                          )
                        : GestureDetector(
                            onTap: () async {
                              if (path.path == '') {
                                CustomSnack(
                                    'Error', 'select a pdf file to upload');
                                return;
                              }
                              context
                                  .read<Controller>()
                                  .uploadCV(path.path, context);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15.0),
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
