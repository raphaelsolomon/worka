import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/applicant/re_edit_applicant.dart';

class ReApplicantProfile extends StatefulWidget {
  const ReApplicantProfile({super.key});

  @override
  State<ReApplicantProfile> createState() => _ReApplicantProfileState();
}

class _ReApplicantProfileState extends State<ReApplicantProfile> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
                    Text(
                      'Profile',
                      style: GoogleFonts.lato(
                          fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        width: .9, color: Colors.black12.withOpacity(.3))),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                      radius: 30,
                      backgroundImage: NetworkImage(''),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Oluwatobi Ogunjimi',
                            style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Production Manager',
                            style: GoogleFonts.lato(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: DEFAULT_COLOR,
                        size: 18.0,
                      ),
                      onPressed: () => Get.to(() => ReApplicantProfileEdit()),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: DEFAULT_COLOR,
                        ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            _items('Professional Summary', Icons.person, () {}),
                            _items('Education', Icons.book, () {}),
                            _items('Work Experience', Icons.work_history, () {}),
                            _items('Skills', Icons.trending_down, () {}),
                            _items('Certification', Icons.star_border_outlined, () {}),
                            _items('Languages', Icons.person, () {}),
                            _items('Availablility', Icons.timelapse, () {}),
                            _items('Resume/CV', Icons.file_open, () {}),
                            _items('Additional Information', Icons.person_add, () {}),
                          ]))))
            ],
          ),
        ],
      )),
    );
  }

  Widget _items(text, icon, callBack) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: DEFAULT_COLOR_1,
                  size: 18.0,
                ),
                const SizedBox(
                  width: 18.0,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: Text(text,
                        style: GoogleFonts.lato(
                            fontSize: 15.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600))),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => callBack(),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: DEFAULT_COLOR_1,
                    size: 18.0,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 9.0,
            ),
            Divider(),
          ],
        ),
      );
}
