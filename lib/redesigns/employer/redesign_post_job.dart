import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/preview_post_job.dart';

class RePostJobs extends StatefulWidget {
  const RePostJobs({super.key});

  @override
  State<RePostJobs> createState() => _RePostJobsState();
}

class _RePostJobsState extends State<RePostJobs> {
  bool isLoading = false;
  bool isJobDesc = true;
  CompModel? compModel = null;
  final jobBenfits = TextEditingController();
  final jobReqirement = TextEditingController();
  final jobQualification = TextEditingController();
  final jobController = TextEditingController();
  final jobDescController = TextEditingController();
  String budget = '';
  String jobType = '';
  String categories = '';
  String currency = 'USD';
  String stringStart = '';
  var jobTypeItem = ['Job Type', 'Full Time', 'Part Time', 'Contract'];
  var SALARY = [
    '1.5M - 2M Annually',
    '950K - 1.5M Annually',
    '500K - 950K Annually',
    '300k - 500k Monthly',
    '150k - 300k Monthly',
    '100K - 150k Monthly',
    '50K - 80K Bi-Weekly',
    '30K - 50K Bi-Weekly',
    '15K - 30K Bi-Weekly',
    '1K - 2k /hr',
    '500 - 1k /hr',
    '300 - 500 /hr'
  ];
  var jobCategoryItem = [
    "Heritage, culture and libraries",
    "Transport, distribution and logistics",
    "Manufacturing and production",
    "Hairdressing and beauty",
    "Animals, land and environment",
    "Performing arts and media",
    "Engineering",
    "Education and training",
    "Security, uniformed and protective services",
    "Retail and customer services",
    "Hospitality, catering and tourism",
    "Administration, business and management",
    "Legal and court services",
    "Healthcare",
    "Print and publishing, marketing and advertising",
    "Languages",
    "Science",
    "mathematics and statistics",
    "Financial services",
    "Sport and leisure",
    "Social work and caring services",
    "Facilities and property services",
    "Computing and ICT",
    "Marketing",
    "Garage services",
    "Design, arts and crafts",
    "Alternative therapies",
    "Social sciences and religion",
    "Construction and building",
    "Agriculture",
    "Animal science",
    "Leadership",
    "Human resources"
  ];

  fetchData(BuildContext context) async {
    return await context.read<EmpController>().getEmployerDetails(context);
  }

  @override
  void initState() {
    fetchData(context).then((value) {
      setState(() {
        compModel = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: DEFAULT_COLOR,
                  )),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                'Post a Job',
                style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
              )
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  inputWidget(
                      text: 'Job Title',
                      icons: Icons.shopping_basket,
                      hint: 'Production Manager',
                      ctl: jobController),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputWidgetRich(ctl: jobDescController), // Description
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputWidgetRich(
                      text: 'Job Requirements',
                      icons: Icons.shopping_basket,
                      hint: 'Enter Job Requirements',
                      ctl: jobReqirement),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputWidgetRich(
                      text: 'Job Qualification',
                      icons: Icons.school_outlined,
                      hint: 'Enter Job Qualification',
                      ctl: jobQualification),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputWidgetRich(
                      text: 'Job Benefits',
                      icons: Icons.school_outlined,
                      hint: 'Enter Job Benefits',
                      ctl: jobBenfits),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputDropDown(SALARY,
                      text: 'Choose Budget',
                      icons: Icons.shopping_bag,
                      hint: '100k - 450k Monthly', callBack: (s) {
                    budget = s;
                  }),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputDropDown(CURRENCY,
                      text: 'Choose Currency',
                      icons: Icons.shopping_bag,
                      hint: 'USD', callBack: (s) {
                    currency = s;
                  }),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputDropDown(jobTypeItem,
                      text: 'Job Type',
                      icons: Icons.location_on,
                      hint: 'FullTime',
                      callBack: (s) => jobType = s),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputDropDown(jobCategoryItem,
                      text: 'Required Categories',
                      icons: Icons.timelapse,
                      hint: 'Search to add Categories',
                      callBack: (s) => categories = s),
                  const SizedBox(
                    height: 25.0,
                  ),
                  inputExp(),
                  const SizedBox(
                    height: 45.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.redAccent.withOpacity(.1)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_open,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attach File',
                                style: GoogleFonts.lato(
                                    color: Colors.black54, fontSize: 15.0),
                              ),
                              Text(
                                'Not more than 1MB',
                                style: GoogleFonts.lato(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      executeData();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DEFAULT_COLOR),
                        child: Center(
                          child: Text(
                            'Submit',
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
      )),
    );
  }

  executeData() async {
    var data = {
      'title': jobController.text.trim(),
      'description': jobDescController.text.trim(),
      'qualification': jobQualification.text.trim(),
      'job_type': '$jobType'.toLowerCase(),
      'categories': '$categories'.toLowerCase(),
      'requirement': '${jobReqirement.text.trim()}',
      'budget': '${budget.trim()}',
      'benefit': '${jobBenfits.text.trim()}',
      'salary_type': '$budget'.split(' ')[3].toLowerCase(),
      'currency': '$currency'.toLowerCase(),
      'is_remote': '${false}',
      'expiry': '$stringStart',
      'location': compModel!.location
    };
    Get.to(() => RePostJobsPreview(Map.from(data)));
  }

  Widget inputWidget(
      {text = 'Job Title', icons = Icons.person, hint = 'Job Title', ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            controller: ctl,
            style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                hintText: '$hint',
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }

  Widget inputExp({text = 'Job Expiry Date', hint = 'Job Title'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'yyyy-MM-dd',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            dateLabelText: 'Expire date',
            decoration: InputDecoration(
                labelStyle: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
                hintStyle:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 9.9),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
            onChanged: (val) => stringStart = val,
          ),
        )
      ],
    );
  }

  Widget inputWidgetRich(
      {text = 'Job Description', icons = Icons.edit, hint = 'Type here', ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            controller: ctl,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: GoogleFonts.lato(fontSize: 16.0, color: Colors.black54),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                hintText: '$hint',
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }

  Widget inputDropDown(List<String> list,
      {text = 'Benefits',
      icons = Icons.shield_sharp,
      hint = 'Insurance',
      callBack}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '$text',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          height: 45.0,
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FormBuilderDropdown(
            name: 'dropDown',
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            // initialValue: 'Male',
            onChanged: (s) => callBack(s),
            hint: Text('$hint',
                style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
            items: list
                .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(
                        '$s',
                        style: GoogleFonts.lato(
                            fontSize: 15.0, color: Colors.black54),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
