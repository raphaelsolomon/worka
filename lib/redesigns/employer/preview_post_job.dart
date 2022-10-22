import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:worka/employer_page/EmployerNav.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/re_company_profile.dart';

import '../../controllers/constants.dart';

class RePostJobsPreview extends StatefulWidget {
  final Map<String, String> data;
  const RePostJobsPreview(this.data, {super.key});

  @override
  State<RePostJobsPreview> createState() => _RePostJobsPreviewState();
}

class _RePostJobsPreviewState extends State<RePostJobsPreview> {
  bool isJobDesc = true;
  CompModel? compModel = null;
  bool isLoading = true;

  fetchProfile(BuildContext context) async {
    return await context.read<EmpController>().getEmployerDetails(context);
  }

  @override
  void initState() {
    fetchProfile(context).then((value) {
      setState(() {
        compModel = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
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
                      Icons.bookmark_outline,
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
                          border: Border.all(width: .5, color: Colors.black54)),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: DEFAULT_COLOR.withOpacity(.1),
                            radius: 40,
                            backgroundImage:
                                NetworkImage('${compModel!.companyLogo}'),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${compModel!.position}'.capitalize!,
                            style: GoogleFonts.lato(
                                fontSize: 19.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  '${compModel!.location}',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: DEFAULT_COLOR.withOpacity(.1)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                    '${widget.data['job_type']}'.capitalize!,
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0,
                                        color: DEFAULT_COLOR,
                                        fontWeight: FontWeight.bold),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Posted ${DateFormat('MMM, yyyy').format(DateTime.now())}',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '${widget.data['budget']}',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.bold),
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
                          onTap: () => setState(() => isJobDesc = true),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                            Get.to(() => ReCompanyProfile());
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
                                color:
                                    !isJobDesc ? DEFAULT_COLOR : Colors.black26,
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
                        ? getJobDescription(widget.data)
                        : getAboutCompany(compModel!),
                    const SizedBox(
                      height: 25.0,
                    ),
                    isLoading ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: CircularProgressIndicator(color: DEFAULT_COLOR,))) : GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        context
                            .read<EmpController>()
                            .postJobs(context, widget.data)
                            .then((v) {
                          if (v == 'success') {
                            setState(() {
                              isLoading = false;
                            });
                            Get.offAll(() => EmployerNav());
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: DEFAULT_COLOR),
                          child: Center(
                            child: Text(
                              'Submit Now',
                              style: GoogleFonts.lato(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}

Widget getAboutCompany(CompModel compModel) => Column(children: [
      Text('Job Description:',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 10.0,
      ),
      Text(TERM1,
          style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Requirements:',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 10.0,
      ),
      Text(TERM1,
          style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54)),
      const SizedBox(
        height: 18.0,
      ),
      Text('Benefits:',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 10.0,
      ),
      ...List.generate(
          3,
          (i) => Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: DEFAULT_COLOR,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text('Health Insurance',
                      style: GoogleFonts.lato(
                          fontSize: 17.0, color: Colors.black54))
                ],
              )),
      const SizedBox(
        height: 18.0,
      ),
      Text('Required Skills:',
          style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
      const SizedBox(
        height: 10.0,
      ),
      ...List.generate(
          3,
          (i) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                  color: DEFAULT_COLOR.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: .5, color: DEFAULT_COLOR)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Production',
                      style: GoogleFonts.lato(
                          fontSize: 13.0, color: DEFAULT_COLOR)),
                  const SizedBox(width: 15.0),
                  Text('x',
                      style: GoogleFonts.lato(
                          fontSize: 13.0, color: DEFAULT_COLOR)),
                ],
              ))),
    ]);

Widget getJobDescription(Map data) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Job Description:',
          style: GoogleFonts.lato(
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10.0,
      ),
      Text('${data['description']}',
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
      Text('${data['requirement']}',
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
      Text('${data['qualification']}',
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
      ...List.generate(1, (i) {
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
              child: Text('${data['benefit']}',
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
            3,
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
