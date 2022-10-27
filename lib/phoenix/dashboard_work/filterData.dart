// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/phoenix/model/SeeMore.dart';
import 'package:http/http.dart' as http;
import '../Controller.dart';
import '../CustomScreens.dart';
import '../model/Constant.dart';
import 'JobDetailsScreen.dart';

class FilterData extends StatefulWidget {
  List<SeeMore> seeMore;
  FilterData(this.seeMore, {Key? key}) : super(key: key);

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Filter Items',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.transparent,
                    onPressed: null,
                  ),
                ),
              ]),
              Expanded(
                  child: widget.seeMore.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (c, i) =>
                              moreJobItems(widget.seeMore[i]),
                          itemCount: widget.seeMore.length,
                        )
                      : Center(
                          child: Text('No Data Found',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.black)),
                        ))
            ],
          ),
        ));
  }

  Padding moreJobItems(SeeMore see) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8.0),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(12.0),
        onTap: () async {
          Get.to(() => JobDetailsScreen(see.jobKey!));
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
