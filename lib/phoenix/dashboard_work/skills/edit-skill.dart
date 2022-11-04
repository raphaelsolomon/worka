import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';
import '../Success.dart';

class EditSkill extends StatefulWidget {
  final Skill skill;
  EditSkill(this.skill, {Key? key}) : super(key: key);

  @override
  State<EditSkill> createState() => _EditSkillState();
}

class _EditSkillState extends State<EditSkill> {
  late final TextEditingController skill_name;
  late String level;
  late String year;
  bool isLoading = false;
  bool isDelete = false;
  bool isUpdate = false;

  @override
  void initState() {
    setState(() {
      skill_name = TextEditingController(text: widget.skill.skillName);
      level = widget.skill.level!;
      year = widget.skill.yearOfExperience!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
      child: SingleChildScrollView(
          child: Column(
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
                style: GoogleFonts.lato(fontSize: 18, color: Color(0xff0D30D9)),
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
          CustomAutoGeneral('Add Skills', 'skills', skill_name),
          SizedBox(
            height: 10.0,
          ),
          inputDropDown(SILLSLEVEL, callBack: (s) {
            setState(() {
              level = s;
            });
          }, hint: '${widget.skill.level}', text: 'Level'),
          SizedBox(
            height: 10.0,
          ),
          inputDropDown(YEARS, callBack: (s) {
            setState(() {
              year = s;
            });
          },
              hint: '${widget.skill.yearOfExperience} years',
              text: 'Years of experience'),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: isDelete
                ? Container()
                : Center(
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: CircularProgressIndicator(),
                          )
                        : GeneralButtonContainer(
                            name: 'Update',
                            color: Color(0xff0D30D9),
                            textColor: Colors.white,
                            onPress: () {
                              setState(() {
                                isLoading = true;
                                isUpdate = true;
                              });
                              var data = {
                                'skill_name': skill_name.text.trim(),
                                'level': level,
                                'year_of_experience': year
                              };
                              executeData(data);
                            },
                            paddingLeft: 10,
                            paddingRight: 10,
                            paddingTop: 25,
                            paddingBottom: 5,
                          )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: isUpdate
                ? Container()
                : Center(
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: CircularProgressIndicator(color: DEFAULT_COLOR,),
                          )
                        : GeneralButtonContainer(
                            name: 'Delete',
                            color: Colors.red,
                            textColor: Colors.white,
                            onPress: () {
                              setState(() {
                                isLoading = true;
                                isDelete = true;
                              });
                              deleteItem(widget.skill.id);
                            },
                            paddingLeft: 10,
                            paddingRight: 10,
                            paddingTop: 10,
                            paddingBottom: 5,
                          )),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      )),
    )));
  }

  void deleteItem(id) async {
    try {
      final res = await Dio().delete('${ROOT}skilldetails/${widget.skill.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Skill Deleted...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update laguage');
    } finally {
      setState(() {
        isLoading = false;
        isDelete = false;
      });
      context.read<Controller>().getprofileReview();
    }
  }

  void executeData(Map data) async {
    try {
      final res = await Dio().post('${ROOT}skilldetails/${widget.skill.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Skill Updated...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to update laguage');
    } finally {
      setState(() {
        isLoading = false;
        isUpdate = false;
      });
      context.read<Controller>().getprofileReview();
    }
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

  Widget inputDropDown(List<String> list,
      {text = 'Select Level', hint = 'Level', callBack}) {
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
}
