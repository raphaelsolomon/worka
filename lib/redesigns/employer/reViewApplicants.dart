import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/re_application_details.dart';

class ReViewApplicant extends StatelessWidget {
  const ReViewApplicant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.menu,
                          color: DEFAULT_COLOR,
                        )),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.notification_important_outlined,
                              color: DEFAULT_COLOR,
                            )),
                        const SizedBox(width: 15.0),
                        CircleAvatar(
                          backgroundColor: DEFAULT_COLOR.withOpacity(.1),
                          radius: 30,
                          child: Image.network(
                            '',
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Applicants',
                                  style: GoogleFonts.lato(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.search_outlined,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  width: .9, color: Colors.transparent)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
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
                                        Text(
                                          'Fkliy Network inc,',
                                          style: GoogleFonts.lato(
                                              fontSize: 16.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.green.withOpacity(.1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      'Approved',
                                      style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                'Regional Manager',
                                style: GoogleFonts.lato(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 9.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.black26),
                                      Text(
                                        'Lagos, Nigeria',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.panorama_fisheye_outlined,
                                          size: 8.0,
                                        ),
                                        const SizedBox(width: 5.0),
                                        Flexible(
                                          child: Text(
                                            'Posted a week ago',
                                            style: GoogleFonts.lato(
                                                fontSize: 14.0,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                color: Colors.black54,
                                thickness: .2,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ...List.generate(
                                  5,
                                  (i) => Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  child: Image.asset(
                                                    'assets/alert.png',
                                                    width: 50.0,
                                                    height: 50.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 18.0,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Lizzy Abidemi',
                                                        style: GoogleFonts.lato(
                                                            fontSize: 17.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            size: 8.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Text(
                                                            'Production Manager',
                                                            style: GoogleFonts.lato(
                                                                fontSize: 17.0,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () => Get.to(() => ReApplicationDetails()),
                                                        child: Text(
                                                          'View Application',
                                                          style: GoogleFonts.lato(
                                                              fontSize: 15.0,
                                                              color:
                                                                  DEFAULT_COLOR,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            Divider(
                                              color: Colors.black54,
                                              thickness: .2,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      ]))))
            ],
          ),
        ],
      )),
    );
  }
}
