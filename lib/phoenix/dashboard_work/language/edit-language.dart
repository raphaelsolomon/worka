import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';

import '../../Controller.dart';
import '../../CustomScreens.dart';
import '../../GeneralButtonContainer.dart';
import '../../Resusable.dart';
import '../Success.dart';

class EditLanguage extends StatefulWidget {
  final Language lang;
  const EditLanguage(this.lang, {Key? key}) : super(key: key);

  @override
  _EditLanguageState createState() => _EditLanguageState();
}

class _EditLanguageState extends State<EditLanguage> {
  final language = TextEditingController();
  String level = '';
  bool isLoading = false;
  bool isDelete = false;
  bool isUpdate = false;

  @override
  void initState() {
    language.text = widget.lang.language!;
    level = widget.lang.level!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
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
            Text('Language',
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
            child: Text('Select Language',
                style: GoogleFonts.lato(
                    fontSize: 14.0,
                    color: Color(0xff0D30D9),
                    decoration: TextDecoration.none)),
          ),
          SizedBox(
            height: 10.0,
          ),
          CustomAutoText(context, 'select Language', 'Language', language),
          SizedBox(
            height: 10.0,
          ),
          CustomDropDownLanguage(
              ['Fluent', 'Native', 'Beginner', 'Conversational'],
              'Level',
              '$level', (s) {
            setState(() {
              level = s;
            });
          }),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: isDelete
                  ? Container()
                  : isLoading
                      ? CircularProgressIndicator()
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
                              'language': language.text,
                              'level': level
                            };
                            executeData(data);
                          },
                          paddingBottom: 3,
                          paddingLeft: 10,
                          paddingRight: 10,
                          paddingTop: 5,
                        ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: isUpdate
                  ? Container()
                  : isLoading
                      ? CircularProgressIndicator()
                      : GeneralButtonContainer(
                          name: 'Delete',
                          color: Colors.red,
                          textColor: Colors.white,
                          onPress: () {
                            setState(() {
                              isLoading = true;
                              isDelete = true;
                            });
                            deleteItem(widget.lang.id);
                          },
                          paddingBottom: 3,
                          paddingLeft: 10,
                          paddingRight: 10,
                          paddingTop: 5,
                        ),
            ),
          ),
        ],
      ),
    )));
  }

  void deleteItem(id) async {
    try {
      final res = await Dio().delete('${ROOT}languagedetails/${widget.lang.id}',
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Language Updated...',
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
      final res = await Dio().post('${ROOT}languagedetails/${widget.lang.id}',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${context.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Language Updated...',
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
