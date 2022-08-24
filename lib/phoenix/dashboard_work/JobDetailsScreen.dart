import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/dashboard_work/applyJob.dart';

import '../GeneralButtonContainer.dart';
import '../model/JobDetails.dart';
import 'personal-details.dart';

class JobDetailsScreen extends StatefulWidget {
  final String jobkey;
  const JobDetailsScreen(this.jobkey, {Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  AsyncMemoizer asyncMemoizer = new AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace),
                          color: Color(0xff0D30D9),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Text('Job Description',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Color(0xff0D30D9)),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: IconButton(
                          icon: Icon(null),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      )
                    ]),
                FutureBuilder(
                  future: _fetchData(),
                  builder: (ctx, snapshot) => _container(snapshot),
                )
              ],
            ),
          ),
        ));
  }

  _fetchData() async {
    return this.asyncMemoizer.runOnce(() async {
      return await context.read<Controller>().viewJob('${widget.jobkey}');
    });
  }

  Widget _container(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        JobDetails j = snapshot.data;
        return Expanded(child: _items(j));
      } else {
        return Expanded(child: Center(child: const Text('Empty data')));
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Widget _items(JobDetails j) => SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image(
                image: NetworkImage('${j.jobData.employerLogo}'),
                width: 100,
                height: 100),
          ),
          SizedBox(height: 30.0),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(j.jobData.title,
                            style: GoogleFonts.montserrat(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(j.jobData.location,
                      style: GoogleFonts.montserrat(
                          fontSize: 13, color: Colors.grey),
                      textAlign: TextAlign.left),
                  SizedBox(height: 10.0),
                  Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff0D30D9).withOpacity(.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<Controller>()
                                  .setCompanyPage('description');
                            },
                            child: Container(
                              height: 30.0,
                              decoration: context
                                          .watch<Controller>()
                                          .companyPage ==
                                      'description'
                                  ? BoxDecoration(
                                      color: Color(0xFF1B6DF9),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                              child: Center(
                                child: Text('Description',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: context
                                                    .watch<Controller>()
                                                    .companyPage ==
                                                'description'
                                            ? Colors.white
                                            : Colors.black87),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<Controller>()
                                  .setCompanyPage('about');
                            },
                            child: Container(
                              height: 30.0,
                              decoration: context
                                          .watch<Controller>()
                                          .companyPage ==
                                      'about'
                                  ? BoxDecoration(
                                      color: Color(0xFF1B6DF9),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                              child: Center(
                                child: Text('About Company',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: context
                                                    .watch<Controller>()
                                                    .companyPage ==
                                                'about'
                                            ? Colors.white
                                            : Colors.black87),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  context.watch<Controller>().companyPage == 'about'
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('Company name',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.black),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: AutoSizeText(j.jobData.employer.companyName,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.grey),
                                    textAlign: TextAlign.justify),
                              ),

                              SizedBox(height: 20.0),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('Company profile',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.black),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: AutoSizeText(j.jobData.employer.companyProfile,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.grey),
                                    textAlign: TextAlign.justify),
                              ),

                              SizedBox(height: 20.0),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('Successful Hires',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.black),
                                    textAlign: TextAlign.justify),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('${j.jobData.employer.hired}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.grey),
                                    textAlign: TextAlign.start),
                              ),

                              SizedBox(height: 20.0),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('Reviews:',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.black),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                    '${j.jobData.employer.reviews} of 5.0 Ratings',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Colors.grey),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 4.0),
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                updateOnDrag: false,
                                ignoreGestures: true,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              )
                            ],
                          ))
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('Job Description',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.black),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text('${j.jobData.description}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                    textAlign: TextAlign.justify),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text(
                                            'Requirements:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 11.0),
                                              child: AutoSizeText(
                                                  '${j.jobData.requirement}',
                                                  style: GoogleFonts
                                                      .montserrat(
                                                      fontSize:
                                                      13,
                                                      color: Colors
                                                          .grey),
                                                  textAlign:
                                                  TextAlign
                                                      .justify),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),

                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text(
                                            'Qualification:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 11.0),
                                              child: AutoSizeText(
                                                  '${j.jobData.qualification} ',
                                                  style: GoogleFonts
                                                      .montserrat(
                                                      fontSize:
                                                      13,
                                                      color: Colors
                                                          .grey),
                                                  textAlign:
                                                  TextAlign
                                                      .justify),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),

                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text('Job Type:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 13,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 11.0),
                                            child: Text(
                                                j.jobData.isRemote ==
                                                    true
                                                    ? 'Remote'
                                                    : 'Full-Time',
                                                style: GoogleFonts
                                                    .montserrat(
                                                    fontSize:
                                                    13,
                                                    color: Colors
                                                        .grey),
                                                textAlign:
                                                TextAlign
                                                    .center),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),

                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text('Category:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 12,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 11.0),
                                            child: Text(
                                                '${j.jobData.categories}',
                                                style: GoogleFonts
                                                    .montserrat(
                                                    fontSize:
                                                    13,
                                                    color: Colors
                                                        .grey),
                                                textAlign:
                                                TextAlign
                                                    .center),
                                          ),
                                        ],
                                      ),
                                      //==================================================
                                      SizedBox(height: 10.0),

                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text('Salary:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 12,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 11.0),
                                            child: Text(
                                                '${j.jobData
                                                    .currency
                                                    .toUpperCase()} ${j
                                                    .jobData.budget}/${j.jobData.salaryType}',
                                                style: GoogleFonts
                                                    .montserrat(
                                                    fontSize:
                                                    13,
                                                    color: Colors
                                                        .grey),
                                                textAlign:
                                                TextAlign
                                                    .justify),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),

                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text('Benefits:',
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 12,
                                                color: Colors
                                                    .black),
                                            textAlign:
                                            TextAlign.center),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                              Icons
                                                  .panorama_fisheye_outlined,
                                              color: Color(
                                                  0xff0D30D9),
                                              size: 6),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 11.0),
                                              child: Text(
                                                  '${j.jobData.benefit}',
                                                  style: GoogleFonts
                                                      .montserrat(
                                                      fontSize:
                                                      13,
                                                      color: Colors
                                                          .grey),
                                                  textAlign:
                                                  TextAlign
                                                      .justify),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 30.0),
                            ],
                          )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: context.watch<Controller>().isLoading
                        ? Center(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : GeneralButtonContainer(
                            name: j.applied ? 'Applied' : 'Apply now',
                            color: j.applied ? Colors.grey : Color(0xff0D30D9),
                            textColor: Colors.white,
                            onPress: j.applied
                                ? () => null
                                : () {
                                    if (verifyProfile()) {
                                      Get.to(() => PersonalDetails(setMap()));
                                    } else {
                                      Get.to(() => ApplyJob(j.jobData));
                                    }
                                  },
                            paddingBottom: 3,
                            paddingLeft: 30,
                            paddingRight: 30,
                            paddingTop: 5,
                          ),
                  ),
                  SizedBox(height: 30.0),
                ],
              )),
        ]),
      );

  verifyProfile() {
    return (context.read<Controller>().profileModel!.location!.isEmpty &&
        context.read<Controller>().profileModel!.about!.isEmpty);
  }

  setMap() {
    if (context.watch<Controller>().profileModel!.location!.isNotEmpty) {
      var s = context.watch<Controller>().profileModel!.location!.split(', ');
      return {
        'firstname': context.watch<Controller>().profileModel!.firstName,
        'lastname': context.watch<Controller>().profileModel!.lastName,
        'othername': context.watch<Controller>().profileModel!.otherName,
        'countryValue': s.length >= 3 ? s[2] : '',
        'stateValue': s.length >= 2 ? s[1] : '',
        'cityValue': s.length >= 0 ? s[0] : '',
        'about': context.watch<Controller>().profileModel!.about,
      };
    }
    return {
      'firstname': context.watch<Controller>().profileModel!.firstName,
      'lastname': context.watch<Controller>().profileModel!.lastName,
      'othername': context.watch<Controller>().profileModel!.otherName,
      'countryValue': '',
      'stateValue': '',
      'cityValue': '',
      'about': context.watch<Controller>().profileModel!.about,
    };
  }
}
