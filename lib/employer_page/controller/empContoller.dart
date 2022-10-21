import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worka/models/JobAppModel.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/models/SubmittedInterview.dart';
import 'package:worka/models/ViewAppModel.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/models/scriptModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/AlertNotification.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../models/InterviewObj.dart';
import '../../phoenix/dashboard_work/Success.dart';

class EmpController extends ChangeNotifier {
  List<AlertNotification> alertList = [];
  List<MyPosted> postedJobs = [];
  JobAppModel? jobAppList;
  ViewAppModel? profileModel;
  bool isSelected = false;
  ScriptModel? scriptModel;
  List<String> optionsObj = [];
  CompModel? cpModel;
  Map<int, Map<String, List<String>>> objQuestion = {};
  SubmittedInterview? submittedInterview;
  Map<String?, dynamic> objAnswers = {};

  //==================done========================
  Future<List<MyPosted>> getPostedJobs(BuildContext c, ) async {
    try {
      final res = await Dio().get('${ROOT}get_posted_jobs/',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        postedJobs = res.data.map<MyPosted>((json) => MyPosted.fromMap(json)).toList();
        notifyListeners();
      }
    } on SocketException {
    } on Exception {
    }
    return postedJobs;
  }

  //==================done========================
  postJobs(BuildContext c, Map data) async {
    try {
      final res = await Dio().post('${ROOT}postjob/',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'job posted successfully...');
        return 'success';
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return 'error';
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return 'error';
    } finally {
    }
  }

  //==================done========================
  jobApplicationList(BuildContext c, id) async {
    try {
      final res = await Dio().get('${ROOT}job_application_list/$id',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        jobAppList = JobAppModel.fromJson(res.data);
        notifyListeners();
        return jobAppList;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return [];
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return [];
    }
  }

//===================done=========================
  Future<ViewAppModel?> viewApplicationList(BuildContext c, id) async {
    try {
      final res = await Dio().get('${ROOT}view_job_application/$id',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        profileModel = ViewAppModel.fromJson(res.data);
        notifyListeners();
        return profileModel;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return profileModel;
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return profileModel;
    }
    return profileModel;
  }

  //==================done=======================
  createInterview(BuildContext c, id, Map<String, Object> data) async {
    try {
      final res = await Dio().post('${ROOT}create_interview/$id',
          data: data,
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        print(res.data);
        return "success";
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return 'error';
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return 'error';
    }
  }

  //==================done========================
  Future<List<AlertNotification>> fetchNotifications(BuildContext c, ctl) async {
    try {
      final res = await Dio().get('${ROOT}fetch_notifications/',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        alertList = res.data
            .map<AlertNotification>((json) => AlertNotification.fromJson(json))
            .toList();
        return alertList;
      }
      return [];
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return [];
    } on Exception {
      CustomSnack('Error', 'Could Not Fetch Notification. Please try again');
      return [];
    } finally {
      c.read<Controller>().getHotAlert();
      if (ctl != null) ctl.refreshCompleted();
    }
  }

  Future<SubmittedInterview?> viewSubmittedInterview(
      BuildContext c, String id) async {
    try {
      final res = await Dio().get(
          '${ROOT}interview/view_submitted_interviews/$id',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        submittedInterview = SubmittedInterview.fromMap(res.data);
        return submittedInterview;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
    }
    return submittedInterview;
  }

  Future<ScriptModel?> viewEmployeeInterview(BuildContext c, id, uid) async {
    try {
      final res = await Dio().get(
          '${ROOT}interview/view_employee_interview/$id/$uid',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        scriptModel = ScriptModel.fromMap(res.data);
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return scriptModel;
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return scriptModel;
    }
    return scriptModel;
  }

  Future<CompModel?> getEmployerDetails(BuildContext c) async {
    try {
      final res = await Dio().get('${ROOT}employerdetails/',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        cpModel = CompModel.fromMap(res.data);
        notifyListeners();
        return cpModel;
      }
    } on SocketException {
      CustomSnack('Error', 'check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Could not fetch profile. Please try again');
    }
    return cpModel;
  }

//======================0241268587==============================================
  signOut() {
    optionsObj.clear();
    jobAppList = null;
    postedJobs.clear();
    alertList.clear();
    scriptModel = null;
    submittedInterview = null;
    isSelected = false;
    profileModel = new ViewAppModel();
  }

  setOptionObj(List<String> option) {
    this.optionsObj.addAll(option);
    print(this.optionsObj);
    Get.back();
  }

  void clearOptionObj() {
    this.optionsObj.clear();
  }

  clearObjInterview() {
    this.objQuestion.clear();
  }

  setQuestionItem(key, String question, List<String> option) {
    objQuestion.putIfAbsent(key, () => {question: option});
    notifyListeners();
  }

  employmentRequest(
      BuildContext c, id, employee, note, Function load, Function not) async {
    load();
    try {
      final res = await Dio().post('${ROOT}send_employment_request/$id',
          data: {'employees': '$employee', 'note': '$note'},
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'ShortListed Successfully',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return [];
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return [];
    } finally {
      not();
    }
  }

  shortListRequest(
      BuildContext c, id, employee, note, Function load, Function not) async {
    load();
    try {
      final res = await Dio().post('${ROOT}direct_employment_request/$id',
          data: {'employees': '$employee', 'note': '$note'},
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'ShortList Employment Successfully',
              callBack: () => Get.back(),
            ));
      } else {
        CustomSnack('Error', 'Could not shortlist');
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
      return [];
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
      return [];
    } finally {
      not();
    }
  }

  removeQuestionItem(key) {
    objQuestion.remove(key);
    notifyListeners();
  }

  addAnswers(ObjInterviewQuestion e, String answerData) {
    if (objAnswers[e.questionUid] != null) {
      objAnswers[e.questionUid] = answerData;
      return;
    }
    objAnswers.putIfAbsent(e.questionUid, () => answerData);
  }

  addAllAnswers(onData) {
    this.objAnswers = onData;
  }

  clearObj() {
    this.objAnswers.clear();
  }
}
