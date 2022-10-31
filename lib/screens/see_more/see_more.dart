import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/SeeMore.dart' as seeMores;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:worka/redesigns/applicant/re_job_details_apply.dart';
import 'package:worka/redesigns/drawer/re_drawer_applicant.dart';

import '../../phoenix/dashboard_work/filter.dart';

class SeeMore extends StatefulWidget {
  const SeeMore({Key? key}) : super(key: key);

  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  final scaffold = GlobalKey<ScaffoldState>();
  String type = '';
  final textController = TextEditingController();

  @override
  void initState() {
    context.read<Controller>().seeMore();
    execute('').then((value) => {
          setState(() {
            type = value;
          })
        });
    super.initState();
  }

  Future<String> execute(type) async {
    if (type == 'name') {
      return await context.read<Controller>().getUserDetails();
    }
    return await context.read<Controller>().getUserDetailsType();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = context.watch<Controller>().see;
    return Scaffold(
        key: scaffold,
         drawer: ReDrawerApplicant(scaffold),
        body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () => context.read<Controller>().seeMore(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () => scaffold.currentState!.openDrawer(),
                              child: Icon(
                                Icons.menu,
                                color: DEFAULT_COLOR,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: CircleAvatar(
                              maxRadius: 17.0,
                              backgroundColor: Color(0xff1B6DF9),
                              backgroundImage: NetworkImage(
                                  '${context.watch<Controller>().avatar}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 150, 0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Find the',
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                            children: [
                              TextSpan(
                                  text: ' Job',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1)),
                              TextSpan(
                                  text: '\nyou dreamt of',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: CustomSearchForm(
                                    'Search for jobs or position',
                                    TextInputType.text,
                                    ctl: textController,
                                    onChange: null)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: GestureDetector(
                              onTap: () => Get.to(() => FilterPage()),
                              child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: DEFAULT_COLOR,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Icon(
                                    Icons.align_vertical_center_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Recent Jobs',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    textController.text.trim().isEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount:
                                    context.watch<Controller>().see.length,
                                itemBuilder: (context, index) {
                                  return moreJobItems(
                                      context.watch<Controller>().see[index]);
                                }),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                            child: Column(
                              children: items
                                  .where((element) => element.title!
                                      .toLowerCase()
                                      .contains(
                                          textController.text.toLowerCase()))
                                  .map((e) => moreJobItems(e))
                                  .toList(),
                            ),
                          )),
                  ],
                ),
              )),
        ));
  }

   Padding moreJobItems(seeMores.SeeMore see) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8.0),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(12.0),
        onTap: () async {
          Get.to(() => ReJobsDetails(see.jobKey!));
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
                    blurRadius: 9.0)
              ]),
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
                            backgroundImage:
                                NetworkImage('${see.employer_logo}'),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Flexible(
                            child: Text(
                              '${see.title}',
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (see.isLike) {
                          see.isLike = await disLike(see.jobKey);
                        } else {
                          see.isLike = await isLike(see.jobKey);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        see.isLike ? Icons.bookmark : Icons.bookmark_outline,
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
                    see.title!,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 17,
                        color: Colors.black87.withOpacity(.7),
                        fontWeight: FontWeight.w400),
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
                            Icon(Icons.location_on_outlined,
                                color: DEFAULT_COLOR_1.withOpacity(.8),
                                size: 17.0),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                '${see.location}',
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.timelapse_outlined,
                              color: DEFAULT_COLOR_1.withOpacity(.8),
                              size: 17.0),
                          const SizedBox(width: 10.0),
                          Text(
                            '${see.jobType}',
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

  isLike(job_uid) async {
    try {
      final res = await http.Client().get(Uri.parse('${ROOT}like/$job_uid'),
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        return true;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
      return false;
    }
  }

  disLike(job_uid) async {
    try {
      final res = await http.Client().get(Uri.parse('${ROOT}dislike/$job_uid'),
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        return false;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
      return true;
    }
  }
}
