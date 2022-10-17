import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/reViewApplicants.dart';

class ReHomePage extends StatefulWidget {
  const ReHomePage({super.key});

  @override
  State<ReHomePage> createState() => _ReHomePageState();
}

class _ReHomePageState extends State<ReHomePage> {

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
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    'Jobs Posted',
                                    style: GoogleFonts.lato(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Text(
                                'Post a Job',
                                style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
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
                                    width: .9, color: DEFAULT_COLOR)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
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
                                const SizedBox(
                                  height: 10.0,
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
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15.0,
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
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.black54,
                                  thickness: .5,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '5 Applicants',
                                      style: GoogleFonts.lato(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(() => ReViewApplicant()),
                                      child: Text(
                                        'View all',
                                        style: GoogleFonts.lato(
                                            fontSize: 16.0, color: DEFAULT_COLOR),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ]))))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 65.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => counter = 0),
                      child: bottomNavItem(isActive: counter == 0)),GestureDetector(
                        onTap: () => setState(() => counter = 1),
                        child: bottomNavItem(icons: Icons.shopping_bag, text: 'Jobs', isActive: counter == 1)),
                    GestureDetector(
                      onTap: () => setState(() => counter = 2),
                      child: bottomNavItem(icons: Icons.mail_lock_outlined, text: 'Inbox', isActive: counter == 2)), GestureDetector(
                        onTap: () => setState(() => counter = 3),
                        child: bottomNavItem(icons: Icons.person_outline_outlined, text: 'Profile', isActive: counter == 3)),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

Widget bottomNavItem({icons = Icons.home_outlined, text = 'Home', isActive}) =>
    Column(children: [
      Icon(
        icons,
        size: 26.0,
        color: isActive? DEFAULT_COLOR: Colors.black54,
      ),
      const SizedBox(height: 3.0),
      Text(
        '$text',
        style: GoogleFonts.lato(fontSize: 14.0, color: isActive ? DEFAULT_COLOR :  Colors.black54),
      )
    ]);
