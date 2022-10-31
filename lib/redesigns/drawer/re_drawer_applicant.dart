
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/employer_page/employer_settings.dart';
import 'package:worka/employer_page/phoenix/screens/EmpInterviews.dart';
import 'package:worka/interfaces/login_interface.dart';
import 'package:worka/redesigns/applicant/re_app_applicant.dart';
import 'package:worka/redesigns/applicant/re_design_profile.dart';
import 'package:worka/screens/help_center.dart';
import 'package:worka/screens/selection_page.dart';

import '../../employer_page/controller/empContoller.dart';
import '../../phoenix/Controller.dart';
import '../../phoenix/model/Constant.dart';

class ReDrawerApplicant extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ReDrawerApplicant(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<ReDrawerApplicant> createState() => _ReDrawerApplicantState();
}

class _ReDrawerApplicantState extends State<ReDrawerApplicant> {

  String fullname = '';

  @override
  void initState() {
    context.read<Controller>().getUserDetails().then((s) => setState((){
        fullname = s;
        print(s);
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width - 100,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                radius: 35,
                backgroundImage: NetworkImage(
                  '${context.watch<Controller>().avatar}',
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Flexible(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.watch<Controller>().userNames}',
                      style: GoogleFonts.lato(
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${context.watch<Controller>().email}',
                      style: GoogleFonts.lato(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
              child: Column(
            children: [
              items(callBack: () =>  Get.to(() => ReApplicantProfile())),
              const SizedBox(height: 20.0),
              items(icons: Icons.shopping_bag, text: 'My Jobs', callBack: () => Get.to(() => ReApplicationApplicant())),
              const SizedBox(height: 20.0),
              items(icons: Icons.laptop, text: 'Interviews', callBack: () => Get.to(() => EmpInterview())),
              const SizedBox(height: 20.0),
              items(
                  icons: Icons.settings,
                  text: 'Settings',
                  callBack: () => Get.to(() => EmployerSettings())),
              const SizedBox(height: 20.0),
              items(
                  icons: Icons.headphones,
                  text: 'Help Center',
                  callBack: () => Get.to(() => Help_Center())),
            ],
          )),
          InkWell(
            onTap: () {
              ILogin()
                  .logout()
                  .whenComplete(() => {Get.offAll(() => SelectionPage())});
              context.read<EmpController>().signOut();
              context.read<Controller>().logout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_sharp,
                  color: DEFAULT_COLOR,
                  size: 16.0,
                ),
                Text('Sign Out',
                    style:
                        GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text('Version 1.0.2',
              style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54)),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}

Widget items({icons = Icons.person, text = 'Profile', callBack}) {
  return InkWell(
    onTap: () => callBack(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(.2),
                offset: Offset(0.0, 1.0),
                blurRadius: 10.0,
                spreadRadius: 1.0)
          ]),
      child: Row(children: [
        Icon(
          icons,
          size: 18.0,
          color: DEFAULT_COLOR_1,
        ),
        const SizedBox(
          width: 18.0,
        ),
        Text('$text',
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54))
      ]),
    ),
  );
}
