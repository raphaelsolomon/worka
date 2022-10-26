import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignSkills extends StatefulWidget {
  const RedesignSkills({super.key});

  @override
  State<RedesignSkills> createState() => _RedesignSkillsState();
}

class _RedesignSkillsState extends State<RedesignSkills> {
  final searchController = TextEditingController();
  List<String> skills = [];
  bool isLoading = false;

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
                        Icons.keyboard_backspace,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Skills',
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
                  CustomAutoGeneral(
                      context,
                      'Add Skills',
                      'skills',
                      searchController,
                      LanguageClass.getLocalOccupation(
                          searchController.text.trim())),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
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
                                    color: DEFAULT_COLOR.withOpacity(.2),
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
                  )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  isLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: DEFAULT_COLOR,
                          )),
                        )
                      : GestureDetector(
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

  Widget CustomAutoGeneral(BuildContext context, hint, label, ctl, function) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(.04),
              ),
              margin: const EdgeInsets.only(top: 5.0),
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
                  return await LanguageClass.getLocalOccupation(pattern);
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    skills.add(suggestion!);
                  });
                },
                itemBuilder: (ctx, String? suggestion) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  title: Text('$suggestion',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey)),
                ),
                textFieldConfiguration: TextFieldConfiguration(
                  controller: ctl,
                  autofocus: false,
                  style: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.grey),
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Search for skills',
                    suffixIcon: Icon(Icons.search, color: Colors.black54),
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15.0, color: Colors.black54),
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14.0, color: Colors.black54),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}