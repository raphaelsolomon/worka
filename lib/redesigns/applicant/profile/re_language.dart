import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignLanguage extends StatefulWidget {
  const RedesignLanguage({super.key});

  @override
  State<RedesignLanguage> createState() => _RedesignLanguageState();
}

class _RedesignLanguageState extends State<RedesignLanguage> {
  String language = '';
  String proficiency = '';
  List<String> skills = [];

  @override
  void initState() {
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
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.menu,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Add Language',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  inputDropDown(['English US', 'Arabic', 'French'],
                      callBack: (s) => language = s),
                  const SizedBox(
                    height: 12.0,
                  ),
                  inputDropDown(
                      ['Fluent', 'Native', 'Beginner', 'Conversational'],
                      text: 'Language Proficiency',
                      hint: 'Language Proficiency',
                      callBack: (s) => proficiency = s),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
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
            ))
          ],
        ),
      ),
    );
  }

  Widget inputDropDown(List<String> list,
      {text = 'Language', hint = 'Language', callBack}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text',
          style: GoogleFonts.lato(
              fontSize: 15.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
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
