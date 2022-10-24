import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignResume extends StatefulWidget {
  const RedesignResume({super.key});

  @override
  State<RedesignResume> createState() => _RedesignResumeState();
}

class _RedesignResumeState extends State<RedesignResume> {
  bool isAvailable = true;

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
                        Icons.menu,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Your Resume/CV',
                    style:
                        GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 10.0),
                  DottedBorder(
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25.0),
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
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.redAccent.withOpacity(.1)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attach File.pdf',
                                  style: GoogleFonts.lato(
                                      color: Colors.black54, fontSize: 15.0),
                                ),
                                Text(
                                  '199Kb',
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
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
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
            ))
          ],
        ),
      ),
    );
  }

  getCardForm(b, text, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () => callBack(),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: b ? Colors.black54 : DEFAULT_COLOR, width: 1.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
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
