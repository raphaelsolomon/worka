import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';

class LoadingController extends ChangeNotifier {
  bool isAddExperience = false;
  String level = '';
  String certificate = '';
  String skillLevel = '';
  String yearsOfExperience = '1';

  setYearsOfExperience(s) {
    yearsOfExperience = s;
    notifyListeners();
  }

  setLevel(s) {
    level = s;
    notifyListeners();
  }

  setSkillLevel(s) {
    skillLevel = s;
    notifyListeners();
  }

  setAddExperience(bool value) {
    isAddExperience = value;
    notifyListeners();
  }

  setCertificate(s) {
    certificate = s;
    notifyListeners();
  }

  void addExperience(
      title, cp_name, stringStart, stringStop, desc, BuildContext c) async {
    isAddExperience = true;
    notifyListeners();
    //===============================ADD EXPERIENCE======================
    try {
      final res = await Dio().post('${ROOT}addworkexperince/',
          data: {
            'title': '$title',
            'company_name': '$cp_name',
            'current': c.read<Controller>().isCurrently,
            'start_date': '$stringStart',
            'end_date': '$stringStop',
            'description': '$desc'
          },
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Experience added...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
    } on Exception {
    } finally {
      isAddExperience = false;
      notifyListeners();
      c.read<Controller>().getprofileReview();
    }
  }
}
