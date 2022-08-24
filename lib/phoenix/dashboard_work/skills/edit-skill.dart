import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';
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
          imageView('${context.watch<Controller>().avatar}'),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Skills',
                style: GoogleFonts.lato(
                    fontSize: 14.0,
                    color: Color(0xff0D30D9),
                    decoration: TextDecoration.none)),
          ),
          SizedBox(
            height: 10.0,
          ),
          CustomAutoGeneral(context, 'Add Skills', 'skills', skill_name,
              LanguageClass.getLocalOccupation(skill_name.text.trim())),
          SizedBox(
            height: 10.0,
          ),
          CustomDropDown(SILLSLEVEL, callBack: (s) {
            setState(() {
              level = s;
            });
          }, hint: '${widget.skill.level}', name: 'Level'),
          SizedBox(
            height: 10.0,
          ),
          CustomDropDown(YEARS, callBack: (s) {
            setState(() {
              year = s;
            });
          },
              hint: '${widget.skill.yearOfExperience} years',
              name: 'Years of experience'),
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
                            child: CircularProgressIndicator(),
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
}
