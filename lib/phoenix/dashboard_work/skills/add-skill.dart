import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../../controllers/constants.dart';
import '../../../controllers/loading_controller.dart';
import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';

class AddSkills extends StatefulWidget {
  AddSkills({Key? key}) : super(key: key);

  @override
  State<AddSkills> createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  final skill_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
      child: Container(
        child: addSkills(context, skill_name),
      ),
    ));
  }

  Widget CustomAutoGeneral(hint, label, ctl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
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
                    ctl.text = suggestion!;
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
      
  Widget inputDropDown(List<String> list, {text = 'Select Level', hint = 'Level', callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
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
                  style:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
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
      ),
    );
  }

  Widget addSkills(BuildContext context, skills) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () => Get.back(),
              ),
            ),
            Text('Skills',
                style: GoogleFonts.montserrat(
                    fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.w500),
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
          const SizedBox(height: 20.0),
          imageView('${context.watch<Controller>().avatar}', context),
          const SizedBox(height: 30),
          CustomAutoGeneral('Add Skills', 'skills', skills),
          SizedBox(
            height: 10.0,
          ),
          inputDropDown(SILLSLEVEL,
              callBack: (s) =>
                  context.read<LoadingController>().setSkillLevel(s),
              hint: 'Select Level',
              text: 'Level'),
          SizedBox(
            height: 10.0,
          ),
          inputDropDown(YEARS,
              callBack: (s) =>
                  context.read<LoadingController>().setYearsOfExperience(s),
              hint: 'Select years of experience',
              text: 'Years of experience'),
          SizedBox(
            height: 30.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: context.watch<Controller>().isSkillsLoading
                ? Center(child: CircularProgressIndicator(color: DEFAULT_COLOR,))
                : GeneralButtonContainer(
                    name: 'Add Skill',
                    color: Color(0xff0D30D9),
                    textColor: Colors.white,
                    onPress: () => context.read<Controller>().addSkills(
                        skills.text,
                        context.read<LoadingController>().skillLevel,
                        context.read<LoadingController>().yearsOfExperience),
                    paddingBottom: 3,
                    paddingLeft: 10,
                    paddingRight: 10,
                    paddingTop: 5,
                  ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );
}

