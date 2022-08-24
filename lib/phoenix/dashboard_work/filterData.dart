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
                              listItem(context, widget.seeMore[i]),
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

  Widget listItem(ctx, SeeMore? see) => Container(
        width: MediaQuery.of(ctx).size.width,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: InkWell(
          splashColor: Colors.blue.withOpacity(.2),
          borderRadius: BorderRadius.circular(10.0),
          onTap: () async {
            if (context.read<Controller>().type == 'employee')
              Get.to(() => JobDetailsScreen('${see!.jobKey}'));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        '${see!.title}'.capitalizeFirst!,
                        minFontSize: 12.0,
                        maxFontSize: 18.0,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w600),
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
                      color: DEFAULT_COLOR,
                      icon: Icon(
                          see.isLike ? Icons.favorite : Icons.favorite_border),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Text(
                  '${see.currency!.toUpperCase()} ${see.budget}/${see
                      .salaryType.toString().capitalizeFirst}',
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ReadMoreText(
                  '${see.description}',
                  trimLines: 1,
                  colorClickableText: DEFAULT_COLOR,
                  trimMode: TrimMode.Line,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  trimCollapsedText: '\nShow more',
                  trimExpandedText: '\nShow less',
                  moreStyle: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                  lessStyle: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                    child: Text(
                      '${see.jobType}',
                      style: GoogleFonts.montserrat(
                          fontSize: 13.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                    child: '${see.isRemote}' == 'true'
                        ? Text(
                            'Remote,\nNigeria',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          )
                        : Text(
                            'Nigeria',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                  ),
                ],
              )
            ],
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
