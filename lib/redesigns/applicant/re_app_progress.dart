import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/dashboard_work/JobDetailsScreen.dart';
import 'package:worka/phoenix/model/Constant.dart';

class ReAppProgress extends StatefulWidget {
  const ReAppProgress({super.key});

  @override
  State<ReAppProgress> createState() => _ReAppProgressState();
}

class _ReAppProgressState extends State<ReAppProgress> {
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
                        Icons.keyboard_backspace,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Application Progress',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1.0, color: Colors.black12),
                      color: Colors.white,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(''),
                            radius: 30.0,
                            backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                          ),
                          const SizedBox(width: 20.0),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Google LLC',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 10.0),
                                Text('Project Manager',
                                    style: GoogleFonts.lato(
                                        fontSize: 19.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10.0),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    decoration: BoxDecoration(
                                        color: DEFAULT_COLOR.withOpacity(.2),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            width: .5, color: DEFAULT_COLOR)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Application Sent',
                                            style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DEFAULT_COLOR,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text('Applications Status',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: DEFAULT_COLOR.withOpacity(.2),
                                offset: Offset(0.0, 1.0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0)
                          ],
                          color: Colors.grey.shade100),
                      child: Center(
                        child: Text(
                          'Pending',
                          style: GoogleFonts.lato(
                              fontSize: 15.0, color: Colors.black),
                        ),
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: Colors.black45,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text('Send a Message',
                          style: GoogleFonts.lato(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400)),
                    ],
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

  Padding hotListingMethod(String avatar, String job, String salary, String location, String key) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(12.0),
        onTap: () async {
          //if (context.read<Controller>().type == 'employee')
          Get.to(() => JobDetailsScreen(key));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: DEFAULT_COLOR.withOpacity(.1),
                offset: Offset(0.0, 4.0),
                spreadRadius: 1.0,
                blurRadius: 9.0
              )
            ]
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                            backgroundImage: NetworkImage('$avatar'),
                          ),
                          const SizedBox(width: 20.0,), 
                          Flexible(
                                child: Text(
                                  'Worka Networks inc,',
                                  maxLines: 1,
                                  style: GoogleFonts.lato(
                                      fontSize: 17,
                                      color: Colors.black87.withOpacity(.7),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        // if (see.isLike) {
                        //   see.isLike = await disLike(see.jobKey);
                        // } else {
                        //   see.isLike = await isLike(see.jobKey);
                        // }
                        // setState(() {});
                      },
                     
                      icon: Icon(
                        // see.isLike ? Icons.favorite : Icons.favorite_border,
                        Icons.bookmark_outline,
                        size: 28.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    job,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: DEFAULT_COLOR_1.withOpacity(.8), size: 17.0 ),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                '$location',
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                  color: Colors.black45,
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.timelapse_outlined, color: DEFAULT_COLOR_1.withOpacity(.8), size: 17.0 ),
                          const SizedBox(width: 10.0),
                          Text(
                            'Full-time',
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
