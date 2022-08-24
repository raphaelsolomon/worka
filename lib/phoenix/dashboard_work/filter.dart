import 'dart:convert';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/SeeMore.dart';

import '../../controllers/constants.dart';
import '../Controller.dart';
import '../CustomScreens.dart';
import '../GeneralButtonContainer.dart';
import '../Resusable.dart';
import 'filterData.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String experience = 'entry level';
  String jobType = "Part time";
  String salary = '100 - 300';
  String category = "";
  String currency = "";
  String start = "100000";
  String end = "300000";
  String? address0 = 'Country';
  String? address1 = 'State';
  String? address2 = 'City';
  bool isLoading = false;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 5.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            color: Color(0xff0D30D9),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Text('Filter',
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
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          CustomDropDown([
                            "Full time",
                            "Part time",
                            "Contract",
                            "Internship",
                            "Voluntary"
                          ], callBack: (s) {
                            jobType = s;
                          },
                              name: 'type',
                              hint: 'Job type',
                              right: 10.0,
                              left: 10.0),
                          SizedBox(height: 20.0),
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
                              child: CustomDropDown(jobCategoryItem.toList(),
                                  callBack: (s) {
                                category = s;
                              },
                                  name: 'category',
                                  hint: 'Category',
                                  right: 10.0,
                                  left: 10.0),
                            ),
                          ]),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Experience Level',
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          _experience(),
                          SizedBox(height: 10.0),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Salary type',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          _salary(),
                          SizedBox(height: 50.0),
                          buildCSC(),
                          SizedBox(height: 40.0),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: isLoading
                                ? Center(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : GeneralButtonContainer(
                                    name: 'Search',
                                    color: Color(0xff0D30D9),
                                    textColor: Colors.white,
                                    onPress: () => executeData(),
                                    paddingBottom: 3,
                                    paddingLeft: 30,
                                    paddingRight: 30,
                                    paddingTop: 5,
                                  ),
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ))
                ])));
  }

  Widget _experience() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Radio<bool>(
                    value: experience == 'entry level',
                    groupValue: true,
                    onChanged: (s) {
                      setState(() {
                        experience = 'entry level';
                      });
                    }),
                Text('Entry Level',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
            Row(
              children: [
                Radio<bool>(
                    value: experience == 'intermediate',
                    groupValue: true,
                    onChanged: (s) {
                      setState(() {
                        experience = 'intermediate';
                      });
                    }),
                Text('Intermediate',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
            Row(
              children: [
                Radio<bool>(
                    value: experience == 'expert',
                    groupValue: true,
                    onChanged: (s) {
                      setState(() {
                        experience = 'expert';
                      });
                    }),
                Text('Expert',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
          ],
        ),
      );

  Widget _salary() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Radio<bool>(
                    value: salary == '100 - 300',
                    groupValue: true,
                    onChanged: (s) {
                      start = '100000';
                      end = '300000';
                      setState(() {
                        salary = '100 - 300';
                      });
                    }),
                Text('100k - 300k',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
            Row(
              children: [
                Radio<bool>(
                    value: salary == '300 - 500',
                    groupValue: true,
                    onChanged: (s) {
                      start = '300000';
                      end = '500000';
                      setState(() {
                        salary = '300 - 500';
                      });
                    }),
                Text('300k - 500k',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
            Row(
              children: [
                Radio<bool>(
                    value: salary == '500 - 1',
                    groupValue: true,
                    onChanged: (s) {
                      start = '500000';
                      end = '1000000';
                      setState(() {
                        salary = '500 - 1';
                      });
                    }),
                Text('500k - 1M',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal))
              ],
            ),
          ],
        ),
      );

  Widget buildCSC() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CSCPicker(
        currentCountry: 'United States',
        currentState: 'California',
        currentCity: 'Acton',
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border:
                Border.all(color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border:
                Border.all(color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),

        countrySearchPlaceholder: "Country",
        stateSearchPlaceholder: "State",
        citySearchPlaceholder: "City",

        ///labels for dropdown
        countryDropdownLabel: "${address0}",
        stateDropdownLabel: "${address1}",
        cityDropdownLabel: "${address2}",

        selectedItemStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),

        dropdownHeadingStyle: TextStyle(
            color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),

        dropdownItemStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        dropdownDialogRadius: 10.0,
        searchBarRadius: 10.0,
        onCountryChanged: (value) {
          setState(() {
            address0 = value;
          });
        },
        onStateChanged: (value) {
          setState(() {
            address1 = value;
          });
        },
        onCityChanged: (value) {
          setState(() {
            address2 = value;
          });
        },
      ));

  void executeData() async {
    if (address0 == 'Country') {
      CustomSnack('Error', 'Please enter city');
      return;
    }

    if (currency == '') {
      CustomSnack('Error', 'Please Select currency');
      return;
    }

    if (address1 == 'State') {
      CustomSnack('Error', 'Please select country');
      return;
    }

    if (address2 == 'City') {
      CustomSnack('Error', 'Please select state');
      return;
    }

    var data = {
      'job_type': '$jobType'.toLowerCase(),
      'category': '$category'.toLowerCase(),
      'experience': '$experience'.toLowerCase(),
      'budget_start': '$start'.toLowerCase(),
      'budget_end': '$end'.toLowerCase(),
      'currency': '$currency'.toLowerCase(),
      'location': '$address2, $address1, $address0'
    };
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.Client().post(Uri.parse('${ROOT}filter/'),
          body: data,
          headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          });
      if (res.statusCode == 200) {
        final prob = json.decode(res.body);
        List<SeeMore> seeMore =
            prob.map<SeeMore>((json) => SeeMore.fromJson(json)).toList();

        Future.delayed(
            Duration(seconds: 1), () => Get.to(() => FilterData(seeMore)));
      }
    } on SocketException {
      CustomSnack('Error', 'Check internet connection');
    } on Exception {
      CustomSnack('Error', 'unable to submit request');
    } finally {
      context.read<Controller>().seeMore();
      setState(() {
        isLoading = false;
      });
    }
  }
}
