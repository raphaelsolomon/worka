import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/JobDetails.dart';
import 'package:worka/redesigns/applicant/re_apply_job.dart';

class ReJobsDetails extends StatefulWidget {
  final String jobKey;
  const ReJobsDetails(this.jobKey, {super.key});

  @override
  State<ReJobsDetails> createState() => _ReJobsDetailsState();
}

class _ReJobsDetailsState extends State<ReJobsDetails> {
  bool isJobDesc = true;
  final refresh = RefreshController();
  bool isLoading = true;
  JobDetails? jobDetails = null;

  _fetchData() async {
    return await context.read<Controller>().viewJob(widget.jobKey);
  }

  @override
  void initState() {
    _fetchData().then((value) {
      setState(() {
        jobDetails = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          Icon(Icons.keyboard_backspace, color: DEFAULT_COLOR)),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: .5, color: Colors.black54)),
                    child: Icon(
                      null,
                      color: Colors.black54,
                      size: 18.0,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: DEFAULT_COLOR),
                      )
                    : SmartRefresher(
                        controller: refresh,
                        header: WaterDropHeader(),
                        onRefresh: () => _fetchData().then((value) {
                          setState(() {
                            jobDetails = value;
                            refresh.refreshCompleted();
                          });
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          width: .5, color: Colors.black54)),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            DEFAULT_COLOR.withOpacity(.1),
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            '${jobDetails!.jobData.employerLogo}'),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '${jobDetails!.jobData.title}'
                                            .capitalize!,
                                        style: GoogleFonts.lato(
                                            fontSize: 19.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 9.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                '${jobDetails!.jobData.location}',
                                                style: GoogleFonts.lato(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15.0,
                                          ),
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: DEFAULT_COLOR
                                                      .withOpacity(.1)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                              child: Text(
                                                '${jobDetails!.jobData.jobType}'
                                                    .capitalize!,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15.0,
                                                    color: DEFAULT_COLOR,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                        thickness: .5,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              jobDetails!.jobData.categories,
                                              style: GoogleFonts.lato(
                                                  fontSize: 14.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15.0,
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${jobDetails!.jobData.budget} ${jobDetails!.jobData.salaryType}',
                                              style: GoogleFonts.lato(
                                                  fontSize: 14.0,
                                                  color: DEFAULT_COLOR,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: GestureDetector(
                                      onTap: () =>
                                          setState(() => isJobDesc = true),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Job Description',
                                            style: GoogleFonts.lato(
                                                fontSize: 16.0,
                                                color: isJobDesc
                                                    ? DEFAULT_COLOR
                                                    : Colors.black54),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Divider(
                                              thickness: isJobDesc ? 5.0 : 2.0,
                                              color: isJobDesc
                                                  ? DEFAULT_COLOR
                                                  : Colors.black26,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                    Flexible(
                                        child: GestureDetector(
                                      onTap: () => setState(() {
                                        isJobDesc = false;
                                      }),
                                      child: Column(
                                        children: [
                                          Text(
                                            'About Company',
                                            style: GoogleFonts.lato(
                                                fontSize: 16.0,
                                                color: !isJobDesc
                                                    ? DEFAULT_COLOR
                                                    : Colors.black54),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Divider(
                                            thickness: !isJobDesc ? 5.0 : 2.0,
                                            color: !isJobDesc
                                                ? DEFAULT_COLOR
                                                : Colors.black26,
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18.0,
                                ),
                                isJobDesc
                                    ? getJobDescription(jobDetails!.jobData)
                                    : getAboutCompany(jobDetails!.jobData, context),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                isLoading
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: DEFAULT_COLOR,
                                        )))
                                    : GestureDetector(
                                        onTap: jobDetails!.applied
                                            ? () {}
                                            : () => Get.to(() => ReApplyJob(jobDetails!.jobData.jobKey)),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: jobDetails!.applied
                                                    ? Colors.grey.shade200
                                                    : DEFAULT_COLOR),
                                            child: Center(
                                              child: Text(
                                                jobDetails!.applied ? 'Applied' : 'Apply Now',
                                                style: GoogleFonts.lato(
                                                    fontSize: 15.0,
                                                    color: jobDetails!.applied
                                                        ? Colors.black54
                                                        : Colors.white),
                                              ),
                                            )),
                                      ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
          ],
        ),
      )),
    );
  }
}

Widget getAboutCompany(JobData jobData, BuildContext context) => SizedBox(
  width: MediaQuery.of(context).size.width,
  child:   Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
  
    mainAxisSize: MainAxisSize.max,
  
    children: [
  
        Text('About',
  
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
  
        const SizedBox(
  
          height: 10.0,
  
        ),
  
        Text(jobData.employer.companyProfile,
  
            style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54)),
  
        const SizedBox(
  
          height: 18.0,
  
        ),
  
        Text('Successful Hires:',
  
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
  
        const SizedBox(
  
          height: 10.0,
  
        ),
  
        Text('${jobData.employer.hired} Successful Hires',
  
            style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54)),
  
        const SizedBox(
  
          height: 18.0,
  
        ),
  
        Text('Reviews',
  
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
  
        const SizedBox(
  
          height: 10.0,
  
        ),
  
        RatingBar.builder(
  
          initialRating: double.parse('${jobData.employer.reviews}'),
  
          minRating: 1,
  
          itemSize: 15.0,
  
          direction: Axis.horizontal,
  
          allowHalfRating: true,
  
          itemCount: 5,
  
          updateOnDrag: false,
  
          ignoreGestures: true,
  
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
  
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
  
          onRatingUpdate: (rating) {
  
            print(rating);
  
          },
  
        ),
  
        SizedBox(
  
          height: 30.0,
  
        )
  
      ]),
);

Widget getJobDescription(JobData jobData) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Job Description:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobData.description}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Requirements:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobData.requirement}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Qualification:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${jobData.qualification}',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Benefits:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      ...List.generate(jobData.benefit.toString().split(', ').length, (i) {
        return Row(
          children: [
            Icon(
              Icons.shield_outlined,
              color: DEFAULT_COLOR,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text('${jobData.benefit.toString().split(', ')[i]}',
                  style:
                      GoogleFonts.lato(fontSize: 16.0, color: Colors.black54)),
            )
          ],
        );
      }),
      const SizedBox(
        height: 18.0,
      ),
      Text('Required Skills:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Wrap(spacing: 12.0, children: [
        ...List.generate(
            0,
            (i) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                    color: DEFAULT_COLOR.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: .5, color: DEFAULT_COLOR)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Production',
                        style: GoogleFonts.lato(
                            fontSize: 15.0, color: DEFAULT_COLOR)),
                    const SizedBox(width: 15.0),
                    Text('x',
                        style: GoogleFonts.lato(
                            fontSize: 16.0, color: DEFAULT_COLOR)),
                  ],
                ))),
      ])
    ]);
