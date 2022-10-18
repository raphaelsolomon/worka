import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class ReNotification extends StatefulWidget {
  const ReNotification({super.key});

  @override
  State<ReNotification> createState() => _ReNotificationState();
}

class _ReNotificationState extends State<ReNotification> {
  bool isNotification = true;

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
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text('Notifications',
                          style: GoogleFonts.lato(
                              fontSize: 17.0, color: Colors.black54))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    Flexible(
                        child: GestureDetector(
                      onTap: () => setState(() => isNotification = true),
                      child: Column(
                        children: [
                          Text(
                            'All Notifications',
                            style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: isNotification
                                    ? DEFAULT_COLOR
                                    : Colors.black54),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Divider(
                              thickness: isNotification ? 5.0 : 2.0,
                              color: isNotification
                                  ? DEFAULT_COLOR
                                  : Colors.black26,
                            ),
                          )
                        ],
                      ),
                    )),
                    Flexible(
                        child: GestureDetector(
                      onTap: () => setState(() => isNotification = false),
                      child: Column(
                        children: [
                          Text(
                            'Applications',
                            style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: !isNotification
                                    ? DEFAULT_COLOR
                                    : Colors.black54),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            thickness: !isNotification ? 5.0 : 2.0,
                            color: !isNotification
                                ? DEFAULT_COLOR
                                : Colors.black26,
                          )
                        ],
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          _isEmpty(isNotification),
                          const SizedBox(height: 40.0),
                        ])))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _isEmpty(b) => Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text('Empty State',
              style: GoogleFonts.lato(fontSize: 19.0, color: Colors.black54)),
          const SizedBox(height: 20.0),
          Text('You dont have any ${b ? 'Notification' : 'Applicant'} yet.',
              style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
        ]));
