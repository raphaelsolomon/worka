import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/JobAppModel.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/re_application_details.dart';
import 'package:worka/redesigns/employer/re_notification.dart';

class ReViewApplicant extends StatefulWidget {
  final MyPosted postedJob;
  final CompModel compModel;
  const ReViewApplicant(this.postedJob, this.compModel, {super.key});

  @override
  State<ReViewApplicant> createState() => _ReViewApplicantState();
}

class _ReViewApplicantState extends State<ReViewApplicant> {
  JobAppModel? job = null;
  bool isLoading = true;

  @override
  void initState() {
    context
        .read<EmpController>()
        .jobApplicationList(context, widget.postedJob.jobKey)
        .then((value) => setState(() {
              job = value;
              isLoading = false;
            }));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.menu,
                          color: DEFAULT_COLOR,
                        )),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Get.to(() => ReNotification()),
                            child: Icon(
                              Icons.notification_important_outlined,
                              color: DEFAULT_COLOR,
                            )),
                        const SizedBox(width: 15.0),
                        CircleAvatar(
                          backgroundColor: DEFAULT_COLOR.withOpacity(.1),
                          radius: 30,
                          backgroundImage:
                              NetworkImage('${widget.compModel.companyLogo}'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                  child: isLoading? Center(child: CircularProgressIndicator(color: DEFAULT_COLOR,)) : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Applicants',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.search_outlined,
                                  size: 18.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  width: .9, color: Colors.transparent)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              DEFAULT_COLOR.withOpacity(.03),
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              '${widget.compModel.companyLogo}'),
                                        ),
                                        const SizedBox(
                                          width: 25.0,
                                        ),
                                        Text(
                                          '${widget.compModel.companyName}',
                                          style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.green.withOpacity(.1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2.5),
                                    child: Text(
                                      '${widget.postedJob.access}',
                                      style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                '${widget.postedJob.title}'.capitalize!,
                                style: GoogleFonts.lato(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 9.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            size: 17.0, color: Colors.black26),
                                        Text(
                                          '${widget.compModel.location}',
                                          style: GoogleFonts.lato(
                                              fontSize: 13.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.panorama_fisheye_outlined,
                                          size: 8.0,
                                        ),
                                        const SizedBox(width: 5.0),
                                        Flexible(
                                          child: Text(
                                            '${widget.postedJob.budget}',
                                            style: GoogleFonts.lato(
                                                fontSize: 13.0,
                                                color: DEFAULT_COLOR,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                color: Colors.black54,
                                thickness: .2,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ...List.generate(job!.applications!.length, (i) => Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  child: Image.network(
                                                    '${job!.applications![i].applicant!.displayPicture}',
                                                    width: 50.0,
                                                    height: 50.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 18.0,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${job!.applications![i].applicant!.firstName} ${job!.applications![i].applicant!.lastName}',
                                                        style: GoogleFonts.lato(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .panorama_fisheye_outlined,
                                                            size: 8.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Text(
                                                            '${job!.applications![i].applicant!.location}',
                                                            style: GoogleFonts.lato(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () => Get.to(() => ReApplicationDetails(job!.applications![i], widget.postedJob.jobKey!)),
                                                        child: Text(
                                                          'View Application',
                                                          style: GoogleFonts.lato(
                                                              fontSize: 13.0,
                                                              color:
                                                                  DEFAULT_COLOR,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            Divider(
                                              color: Colors.black54,
                                              thickness: .2,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      ]))))
            ],
          ),
        ],
      )),
    );
  }
}
