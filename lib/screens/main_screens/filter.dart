import 'package:flutter/material.dart';
import 'package:worka/reuseables/text_field_dropdown.dart';

enum BestTutorSite { entryLevel, intermediate, expert }
enum SalaryRange { hundred, threeHundred, fiveHundreed }

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late BestTutorSite _site = BestTutorSite.entryLevel;
  late SalaryRange _salary = SalaryRange.hundred;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Filter',
                style: TextStyle(
                  fontSize: 50 / 2,
                  fontFamily: 'Lato',
                  color: Color(0xff0039A5),
                ),
              ),
            ),
          ),
          const CustomDropDown(
            title: 'Sort',
            title2: 'Recents Jobs',
          ),
          const CustomDropDown(
            title: 'Category',
            title2: 'Select Category',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Text('Experience Level',
                style: TextStyle(
                    fontSize: 50 / 3, fontFamily: 'Lato', color: Colors.black)),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Entry Level',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: BestTutorSite.entryLevel,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Intermediate',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: BestTutorSite.intermediate,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Expert',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: BestTutorSite.expert,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Text('Salary Range',
                style: TextStyle(
                    fontSize: 50 / 3, fontFamily: 'Lato', color: Colors.black)),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  '100k - 300k',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: SalaryRange.hundred,
                  groupValue: _salary,
                  onChanged: (SalaryRange? value) {
                    setState(() {
                      _salary = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  '300k - 500k',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: SalaryRange.threeHundred,
                  groupValue: _salary,
                  onChanged: (SalaryRange? value) {
                    setState(() {
                      _salary = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  '500k - 1M',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
                leading: Radio(
                  value: SalaryRange.fiveHundreed,
                  groupValue: _salary,
                  onChanged: (SalaryRange? value) {
                    setState(() {
                      _salary = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const CustomDropDown(
            title: 'Job Location',
            title2: 'Select your prefered loaction',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(55, 25, 55, 100),
            child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff0D30D9)),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
