import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../controllers/constants.dart';

class RePostJobs extends StatelessWidget {
  const RePostJobs({super.key});

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.black54,
                    )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: .5, color: Colors.black54)),
                  child: Icon(
                    Icons.bookmark_outline,
                    color: Colors.black54,
                    size: 18.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: .5, color: Colors.black54)),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlue.withOpacity(.3),
                          radius: 40,
                          child: Image.network(
                            '',
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Production Manager',
                          style: GoogleFonts.lato(
                              fontSize: 18.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              'Lagos, Nigeria',
                              style: GoogleFonts.lato(
                                  fontSize: 14.0, color: Colors.black54),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: DEFAULT_COLOR.withOpacity(.3)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                'Full Time Role',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: Colors.black54,
                          thickness: .5,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Posted May 2021',
                              style: GoogleFonts.lato(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              '#250 - 400k',
                              style: GoogleFonts.lato(
                                  fontSize: 14.0, color: DEFAULT_COLOR),
                            ),
                            Text(
                              'Monthly',
                              style: GoogleFonts.lato(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Column(
                        children: [
                          Text(
                            'Job Description',
                            style: GoogleFonts.lato(
                                fontSize: 14.0, color: DEFAULT_COLOR),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            thickness: 1.0,
                            color: DEFAULT_COLOR,
                          )
                        ],
                      )),
                      Flexible(
                          child: Column(
                        children: [
                          Text(
                            'About company',
                            style: GoogleFonts.lato(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            thickness: .5,
                            color: Colors.black54,
                          )
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text('Job Description:',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(TERM1,
                      style: GoogleFonts.lato(
                          fontSize: 13.0, color: Colors.black54)),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text('Requirements:',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(TERM1,
                      style: GoogleFonts.lato(
                          fontSize: 13.0, color: Colors.black54)),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text('Benefits:',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ...List.generate(
                      3,
                      (index) => Row(
                            children: [
                              Icon(
                                Icons.shield,
                                color: DEFAULT_COLOR,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('Health Insurance',
                                  style: GoogleFonts.lato(
                                      fontSize: 13.0, color: Colors.black54))
                            ],
                          )),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text('Required Skills:',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ...List.generate(3, (index) => Text('')),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DEFAULT_COLOR),
                        child: Center(
                          child: Text(
                            'Submit Now',
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
      )),
    );
  }
}
