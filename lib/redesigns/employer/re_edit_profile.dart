import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../controllers/constants.dart';

class ReEditCompanyProfile extends StatefulWidget {
  const ReEditCompanyProfile({super.key});

  @override
  State<ReEditCompanyProfile> createState() => _ReEditCompanyProfileState();
}

class _ReEditCompanyProfileState extends State<ReEditCompanyProfile> {
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
                                    color: Colors.transparent.withOpacity(.4))),
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
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                ),
                                IconButton(
                                    onPressed: () => Get.to(() => ReEditCompanyProfile()),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black54,
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 45.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black54, width: .5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text('Contact Information',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0, color: Colors.black54)),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              Icon(Icons.email_rounded,
                                  color: Colors.black54, size: 18.0),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('Lagos, Nigeria',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0, color: Colors.black54))
                            ],
                          ),
                          const SizedBox(height: 3.0),
                          Row(
                            children: [
                              Icon(Icons.email_rounded,
                                  color: Colors.black54, size: 18.0),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('info@Fklynetwork.inc',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0, color: Colors.black54))
                            ],
                          ),
                          const SizedBox(height: 3.0),
                          Row(
                            children: [
                              Icon(Icons.email_rounded,
                                  color: Colors.black54, size: 18.0),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('+234 708 9704 086',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0, color: Colors.black54))
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 45.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black54, width: .5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text('About',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0, color: Colors.black54)),
                          ),
                          const SizedBox(height: 8.0),
                          Text(TERM1,
                              style: GoogleFonts.lato(
                                  fontSize: 15.0, color: Colors.black54)),
                          const SizedBox(height: 15.0),
                          Text('Overall Ratings',
                              style: GoogleFonts.lato(
                                  fontSize: 15.0, color: Colors.black54)),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Text('4.6 of 5.0 Ratings',
                              style: GoogleFonts.lato(
                                  fontSize: 14.0, color: Colors.black54)),
                          const SizedBox(
                            height: 7.0,
                          ),
                          RatingBar.builder(
                                  initialRating: 5.0,
                                  minRating: 1,
                                  itemSize: 14.0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  updateOnDrag: false,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) => null,
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
