import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';

import 'JobDetails.dart';

class PostedJobs extends StatelessWidget {
  PostedJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon:
                      Icon(Icons.keyboard_backspace, color: Color(0xff0D30D9))),
              Text('Applied Jobs',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: DEFAULT_COLOR)),
              IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.more_vert),
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(0.0)),
            ],
          ),
        ),
        context.watch<EmpController>().postedJobs.length <= 0
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          ...List.generate(
                              context.watch<EmpController>().postedJobs.length,
                              (index) => listItemDark(
                                  context,
                                  context
                                      .watch<EmpController>()
                                      .postedJobs[index]))
                        ]),
                  ),
                ),
              )
      ],
    )));
  }

  Widget listItemDark(BuildContext ctx, MyPosted see) {
    var date = DateFormat('yyyy-MM-dd').format(see.expiry);
    return Container(
      width: MediaQuery.of(ctx).size.width,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white38.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.withOpacity(.15)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        splashColor: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.0),
        onTap: () async {
          Get.to(() => JobDetailsEmp(see));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 4, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      '${see.title}'.capitalizeFirst!,
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xff1B6DF9).withOpacity(.7),
                    radius: 18,
                    backgroundImage:
                        NetworkImage(ctx.watch<Controller>().avatar),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7.0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Expire Date: $date',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Budget: ${see.budget}',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                    child: AutoSizeText(
                      '${see.categories}',
                      minFontSize: 11,
                      maxFontSize: 18,
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                    child: see.isRemote == true
                        ? AutoSizeText(
                            'Remote, Nigeria',
                            minFontSize: 11,
                            maxFontSize: 18,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.normal),
                          )
                        : AutoSizeText(
                            'Nigeria',
                            minFontSize: 11,
                            maxFontSize: 18,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.normal),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
