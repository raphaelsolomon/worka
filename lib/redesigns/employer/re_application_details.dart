import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../controllers/constants.dart';

class ReApplicationDetails extends StatefulWidget {
  const ReApplicationDetails({super.key});

  @override
  State<ReApplicationDetails> createState() => _ReApplicationDetailsState();
}

class _ReApplicationDetailsState extends State<ReApplicationDetails> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.keyboard_backspace,
                            color: DEFAULT_COLOR,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          const SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    width: .9,
                                    color: Colors.black54.withOpacity(.4))),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      DEFAULT_COLOR.withOpacity(.03),
                                  radius: 30,
                                  child: Image.network(
                                    '',
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fkliy Network inc,',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Production Manager',
                                      style: GoogleFonts.lato(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Icon(Icons.email_rounded,
                                        color: Colors.black54, size: 18.0),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('Boladeaalex@yahoo.com',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Colors.black54))
                                  ],
                                ),
                              ),
                              Text('View Profile',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0, color: DEFAULT_COLOR)),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Divider(
                            thickness: .3,
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 18.0),
                          Text('Add Cover Letter',
                              style: GoogleFonts.lato(
                                  fontSize: 15.0, color: Colors.black54)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(TERM1,
                              style: GoogleFonts.lato(
                                  fontSize: 13.0, color: Colors.black54)),
                          const SizedBox(height: 18.0),
                          Text('Resume/CV',
                              style: GoogleFonts.lato(
                                  fontSize: 15.0, color: Colors.black54)),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Attach File',
                                        style: GoogleFonts.lato(
                                            color: Colors.black54,
                                            fontSize: 15.0),
                                      ),
                                      Text(
                                        'Not more than 1MB',
                                        style: GoogleFonts.lato(
                                            color: Colors.black54,
                                            fontSize: 12.0),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Download Resume',
                            style: GoogleFonts.lato(
                                color: Colors.black54, fontSize: 15.0),
                          ),
                          const SizedBox(height: 40.0),
                          GestureDetector(
                            onTap: () async {
                              Get.to(() => null);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: DEFAULT_COLOR),
                                child: Center(
                                  child: Text(
                                    'Invite for Interview',
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0, color: Colors.white),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 18.0),
                          GestureDetector(
                            onTap: () async {
                              Get.to(() => null);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: DEFAULT_COLOR.withOpacity(.2)),
                                child: Center(
                                  child: Text(
                                    'Decline Application',
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0, color: DEFAULT_COLOR),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 40.0),
                        ]))))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
