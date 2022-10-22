import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:worka/phoenix/model/Constant.dart';

import 'EmployerNav.dart';
import 'controller/empContoller.dart';

class EmployerPostJob extends StatefulWidget {
  final bool type;
  const EmployerPostJob({Key? key, this.type = false}) : super(key: key);

  @override
  _EmployerPostJobState createState() => _EmployerPostJobState();
}

class _EmployerPostJobState extends State<EmployerPostJob> {
  String jobType = 'Select Job Type';
  String position = 'Select Position';
  String industries = "Select Industries";
  String jobCategory = 'Job Category';
  var jobTypeItem = ['Job Type', 'Full Time', 'Part Time', 'Contract'];
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
  int _currentStep = 0;
  bool isLoading = false;
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? salary_type = 'monthly';
  List<int> completed = [];
  bool isRemote = false;
  String? access = 'public';
  //=======================STEP 1==================================
  final jobController = TextEditingController();
  final jobDescController = TextEditingController();
  final budgetController = TextEditingController();
  String currency = 'ALL';
  String jobTypePost = '';
  String stringStart = '';
  String categoryPost = '';
  //=======================STEP 2=================================
  final allowance = TextEditingController();
  final jobReqirement = TextEditingController();
  final jobQualification = TextEditingController();

  //Currency? currency;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: IconButton(
                    icon: widget.type
                        ? Icon(Icons.keyboard_backspace)
                        : Icon(null),
                    color: DEFAULT_COLOR,
                    onPressed: widget.type ? () => Get.back() : null,
                  ),
                ),
                Text('Job Posting',
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
              SizedBox(height: 20.0),
              Expanded(
                child: _currentStep <= 0 ? step1() : step2(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPaddingDropdown(List<String> data, String data1, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: FormBuilderDropdown(
              name: 'skill',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                labelText: data1,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              // initialValue: 'Male',
              //hint: Text(data1),
              onChanged: (s) => callBack(s),
              items: data
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Padding paddingJobDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF1B6DF9).withOpacity(.2))),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: DropdownButton(
          elevation: 10,
          value: jobType,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: jobTypeItem.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(items,
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: Colors.grey)),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              jobType = newValue!;
            });
          },
        ),
      ),
    );
  }

  Padding paddingJobCategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF1B6DF9).withOpacity(.2))),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: DropdownButton(
          elevation: 10,
          value: jobCategory,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: jobCategoryItem.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(items,
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: Colors.grey)),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              jobCategory = newValue!;
            });
          },
        ),
      ),
    );
  }

  Center buildCSC() {
    return Center(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CSCPicker(
                showStates: true,
                showCities: true,
                flagState: CountryFlag.DISABLE,
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(
                        color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(
                        color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),

                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",

                ///labels for dropdown
                countryDropdownLabel: "*Country",
                stateDropdownLabel: "*State",
                cityDropdownLabel: "*City",

                selectedItemStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),

                dropdownHeadingStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                dropdownItemStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
            ],
          )),
    );
  }

  Widget step1() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: Text('Step 1 of 2',
                  style: GoogleFonts.montserrat(color: Colors.grey)),
            ),
            SizedBox(height: 20.0),
            CustomAuthForm('Job Title', 'Job Title', TextInputType.text,
                ctl: jobController, right: 10.0, left: 10.0),
            CustomRichTextForm(jobDescController, 'Job Description',
                'Job Description', TextInputType.multiline, 20,
                horizontal: 10.0),
            buildPaddingDropdown([
              "Full time",
              "Part time",
              "Contract",
              "Internship",
              "Voluntary"
            ], 'Job Type',
                callBack: (s) => {
                      setState(() {
                        jobTypePost = s;
                      })
                    }),
            SizedBox(height: 15.0),
            buildPaddingDropdown(jobCategoryItem.toList(), 'Category',
                callBack: (s) => {
                      setState(() {
                        categoryPost = s;
                      })
                    }),
            SizedBox(height: 15.0),
            buildPaddingDropdown(
                ['Hourly', 'Daily', 'Monthly', 'Weekly', 'Annually'],
                'Salary type',
                callBack: (s) => {
                      setState(() {
                        salary_type = s;
                      })
                    }),
            SizedBox(height: 15.0),
            Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              margin: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'yyyy-MM-dd',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateLabelText: 'Expire date',
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Expire date',
                  labelText: 'Expire date',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 9.9, vertical: 9.9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                ),
                onChanged: (val) => stringStart = val,
              ),
            ),
            SizedBox(height: 15.0),
            Row(children: [
              CustomDropDown(CURRENCY,
                  callBack: (s) => setState(() {
                        currency = s;
                      }),
                  width: 100.0,
                  right: 10.0,
                  left: 10.0,
                  name: 'Currency',
                  hint: 'currency'),
              Flexible(
                  child: CustomAuthForm(
                      'Budget', 'Budget', TextInputType.number,
                      ctl: budgetController, left: 2.0, right: 10.0)),
            ]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: Text(
                            'Back',
                            style: GoogleFonts.montserrat(color: Colors.white),
                          )),
                          height: 45.0)),
                  SizedBox(width: 10.0),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (jobController.text.trim().isNotEmpty) {
                        if (jobDescController.text.trim().isNotEmpty) {
                          if (jobTypePost.isNotEmpty) {
                            if (budgetController.text.trim().isNotEmpty) {
                              if (jobCategory.isNotEmpty) {
                                setState(() {
                                  _currentStep = 1;
                                  completed.add(0);
                                });
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: DEFAULT_COLOR,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                            child: Text(
                          'Next',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        )),
                        height: 45.0),
                  )),
                ],
              ),
            )
          ],
        ),
      );

  Widget step2() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: Text('Step 2 of 2',
                  style: GoogleFonts.montserrat(color: Colors.grey)),
            ),
            SizedBox(height: 20.0),
            CustomRichTextForm(
                allowance,
                'Travel Allowance, Attractive salary, Experience',
                'Benefits',
                TextInputType.multiline,
                null,
                horizontal: 10.0),
            SizedBox(height: 10.0),
            CustomRichTextForm(jobReqirement, 'Job Requirements',
                'Job Requirement', TextInputType.multiline, null,
                horizontal: 10.0),
            SizedBox(height: 10.0),
            CustomRichTextForm(jobQualification, 'Job Qualification',
                'Job Qualification', TextInputType.multiline, null,
                horizontal: 10.0),
            SizedBox(height: 10.0),
            buildCSC(),
            SizedBox(height: 10.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Radio<bool>(
                      value: isRemote,
                      groupValue: true,
                      onChanged: (value) {
                        if (isRemote) {
                          setState(() {
                            isRemote = false;
                          });
                        } else {
                          setState(() {
                            isRemote = true;
                          });
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text("Remote",
                        style: GoogleFonts.montserrat(color: DEFAULT_COLOR)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              _currentStep = 0;
                              completed.clear();
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: DEFAULT_COLOR,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                  child: Text(
                                'Back',
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              )),
                              height: 45.0),
                        )),
                        SizedBox(width: 10.0),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            executeData();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: DEFAULT_COLOR,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                  child: Text(
                                'Submit',
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              )),
                              height: 45.0),
                        )),
                      ],
                    ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      );

  executeData() async {
    var data = {
      'title': jobController.text.trim(),
      'description': jobDescController.text.trim(),
      'qualification': jobQualification.text.trim(),
      'job_type': '$jobTypePost'.toLowerCase(),
      'categories': '$categoryPost'.toLowerCase(),
      'currency': '$currency'.toLowerCase(),
      'budget': '${budgetController.text.trim()}',
      'benefit': '${allowance.text.trim()}',
      'requirement': '${jobReqirement.text.trim()}',
      'salary_type': '$salary_type'.toLowerCase(),
      'is_remote': '$isRemote',
      'expiry': '$stringStart',
      'location': '${cityValue}, ${stateValue}, ${countryValue}'
    };
    String res = await Provider.of<EmpController>(context, listen: false)
        .postJobs(context, data);
    if (res == 'success') {
      setState(() {
        isLoading = false;
      });
      Get.offAll(() => EmployerNav());
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
