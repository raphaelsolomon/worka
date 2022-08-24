import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/dashboard_work/JobDetailsScreen.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/SeeMore.dart' as seeMores;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
        drawer: getDrawer(context, scaffold, name: '', type: type),
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
                                  return hotListingMethod(
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
                                  .map((e) => hotListingMethod(e))
                                  .toList(),
                            ),
                          )),
                  ],
                ),
              )),
        ));
  }

  Widget hotListingMethod(seeMores.SeeMore see) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: InkWell(
          splashColor: Colors.blue.withOpacity(.2),
          borderRadius: BorderRadius.circular(1.0),
          onTap: () async {
            if (context.read<Controller>().type == 'employee')
              Get.to(() => JobDetailsScreen(see.jobKey!));
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.blue.withOpacity(.1),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          '${see.title}'.capitalizeFirst!,
                          minFontSize: 11,
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                          see.isLike ? Icons.favorite : Icons.favorite_border,
                          color: DEFAULT_COLOR,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.blue.withOpacity(.2),
                    ),
                    child: Text(
                      '${see.currency!.toUpperCase()} ${see.budget}/${see
                          .salaryType.toString().capitalizeFirst}',
                      style: GoogleFonts.montserrat(
                          color: Colors.black87,
                          fontSize: 12.5,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: AutoSizeText(
                          '${see.description}',
                          minFontSize: 12,
                          maxFontSize: 20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${see.isRemote}' == true ? 'Remote' : 'FullTime',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${see.location}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.blue.withOpacity(.1),
                ),
              ],
            ),
          ),
        ),
      );
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
