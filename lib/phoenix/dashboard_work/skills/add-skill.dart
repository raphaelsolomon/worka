import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';

import '../../../controllers/constants.dart';
import '../../../controllers/loading_controller.dart';
import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';

class AddSkills extends StatelessWidget {
  AddSkills({Key? key}) : super(key: key);
  final skill_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: addSkills(context, skill_name),
      ),
    ));
  }

  Widget addSkills(BuildContext context, skills) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          const SizedBox(height: 20.0),
          imageView('${context.watch<Controller>().avatar}', context),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Skills',
                style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    color: Color(0xff0D30D9),
                    decoration: TextDecoration.none)),
          ),
          SizedBox(
            height: 10.0,
          ),
          CustomAutoGeneral(context, 'Add Skills', 'skills', skills,
              LanguageClass.getLocalOccupation(skills.text.trim())),
          SizedBox(
            height: 10.0,
          ),
          CustomDropDown(SILLSLEVEL,
              callBack: (s) =>
                  context.read<LoadingController>().setSkillLevel(s),
              hint: 'Select Level',
              name: 'Level'),
          SizedBox(
            height: 10.0,
          ),
          CustomDropDown(YEARS,
              callBack: (s) =>
                  context.read<LoadingController>().setYearsOfExperience(s),
              hint: 'Select years of experience',
              name: 'Years of experience'),
          SizedBox(
            height: 30.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: context.watch<Controller>().isSkillsLoading
                ? Center(child: CircularProgressIndicator())
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
