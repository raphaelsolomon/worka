import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  List<String> skills = [];
  List<String> benefits = [];
  final requiredSkills = TextEditingController();

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
           height: 20.0,
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
                   height: 20.0,
                  ),
                  inputWidgetRich(ctl: jobDescController), // Description
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputWidgetRich(
                      text: 'Job Requirements',
                      icons: Icons.shopping_basket,
                      hint: 'Enter Job Requirements',
                      ctl: jobReqirement),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputWidgetRich(
                      text: 'Job Qualification',
                      icons: Icons.school_outlined,
                      hint: 'Enter Job Qualification',
                      ctl: jobQualification),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputAutoCompleteWidget(
                      text: 'Benfits',
                      icons: Icons.timelapse,
                      b: false,
                      ctl: jobBenfits),
                       SizedBox(height: benefits.isEmpty? 0.0 : 10.0),
                      Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(spacing: 12.0, children: [
                        ...List.generate(
                            benefits.length,
                            (i) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: DEFAULT_COLOR.withOpacity(.09),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: .2, color: DEFAULT_COLOR)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${benefits[i]}',
                                        style: GoogleFonts.lato(
                                            fontSize: 15.0,
                                            color: DEFAULT_COLOR)),
                                    const SizedBox(width: 15.0),
                                    GestureDetector(
                                      onTap: () =>
                                          setState(() => benefits.removeAt(i)),
                                      child: Text('x',
                                          style: GoogleFonts.lato(
                                              fontSize: 16.0,
                                              color: DEFAULT_COLOR)),
                                    ),
                                  ],
                                ))),
                      ]),
                    ),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputDropDown(SALARY,
                      text: 'Choose Budget',
                      icons: Icons.shopping_bag,
                      hint: '100k - 450k Monthly', callBack: (s) {
                    budget = s;
                  }),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputDropDown(CURRENCY,
                      text: 'Choose Currency',
                      icons: Icons.shopping_bag,
                      hint: 'USD', callBack: (s) {
                    currency = s;
                  }),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputDropDown(jobTypeItem,
                      text: 'Job Type',
                      icons: Icons.location_on,
                      hint: 'FullTime',
                      callBack: (s) => jobType = s),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputDropDown(jobCategoryItem,
                      text: 'Required Categories',
                      icons: Icons.timelapse,
                      hint: 'Search to add Categories',
                      callBack: (s) => categories = s),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputAutoCompleteWidget(
                      text: 'Required Skills',
                      icons: Icons.timelapse,
                      b: true,
                      ctl: requiredSkills),
                       SizedBox(height: skills.isEmpty? 0.0 : 10.0),
                      Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(spacing: 12.0, children: [
                        ...List.generate(
                            skills.length,
                            (i) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: DEFAULT_COLOR.withOpacity(.09),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: .5, color: DEFAULT_COLOR)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${skills[i]}',
                                        style: GoogleFonts.lato(
                                            fontSize: 15.0,
                                            color: DEFAULT_COLOR)),
                                    const SizedBox(width: 15.0),
                                    GestureDetector(
                                      onTap: () =>
                                          setState(() => skills.removeAt(i)),
                                      child: Text('x',
                                          style: GoogleFonts.lato(
                                              fontSize: 16.0,
                                              color: DEFAULT_COLOR)),
                                    ),
                                  ],
                                ))),
                      ]),
                    ),
                  const SizedBox(
                   height: 20.0,
                  ),
                  inputExp(),
                  const SizedBox(
                    height: 50.0,
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
                   height: 20.0,
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
      'benefit': benefits.join(', '),
      'skills' : skills.join(', '),
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
            color: DEFAULT_COLOR.withOpacity(.02),
            borderRadius: BorderRadius.circular(8.0),
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

  Widget inputAutoCompleteWidget({text, icons = Icons.person, b, ctl}) {
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
            color: DEFAULT_COLOR.withOpacity(.02),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TypeAheadField<String?>(
            suggestionsBoxController: SuggestionsBoxController(),
            hideSuggestionsOnKeyboardHide: true,
            noItemsFoundBuilder: (context) => Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('No Data Found',
                    style: GoogleFonts.montserrat(
                        color: Colors.grey, fontSize: 12)),
              ),
            ),
            suggestionsCallback: (pattern) async {
              return b
                  ? await LanguageClass.getLocalRequiredSkills(pattern)
                  : await LanguageClass.getLocalBenefit(pattern);
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                b ? skills.add(suggestion!) : benefits.add(suggestion!);
              });
            },
            itemBuilder: (ctx, String? suggestion) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              title: Text('$suggestion',
                  style:
                      GoogleFonts.lato(fontSize: 15, color: Colors.grey)),
            ),
            textFieldConfiguration: TextFieldConfiguration(
              controller: ctl,
              autofocus: false,
              style: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
              decoration: InputDecoration(
                filled: false,
                hintText: 'Search for $text',
                suffixIcon: Icon(Icons.search, color: Colors.black54),
                labelStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
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
            color: DEFAULT_COLOR.withOpacity(.02),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'yyyy-MM-dd',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
            dateLabelText: 'Expire date',
            decoration: InputDecoration(
                labelStyle: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
                hintStyle:
                    GoogleFonts.lato(fontSize: 15.0, color: Colors.grey),
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
            color: DEFAULT_COLOR.withOpacity(.02),
            borderRadius: BorderRadius.circular(8.0),
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
            color: DEFAULT_COLOR.withOpacity(.02),
            borderRadius: BorderRadius.circular(8.0),
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
