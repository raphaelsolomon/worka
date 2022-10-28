// ignore: file_namesimport 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/models/HotAlert.dart';
import 'package:worka/models/InboxModel.dart';
import 'package:worka/models/notificationModel.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/AlertNotification.dart';
import 'package:worka/phoenix/model/ApplyDetails.dart';
import 'package:worka/phoenix/model/AvailablityModel.dart';
import 'package:worka/phoenix/model/EducationModel.dart';
import 'package:worka/phoenix/model/ExperienceModel.dart';
import 'package:worka/phoenix/model/JobDetails.dart';
import 'package:worka/phoenix/model/LanguageModel.dart';
import 'package:worka/phoenix/model/MyJobsModel.dart';
import 'package:worka/phoenix/model/MySkill.dart';
import 'package:worka/phoenix/model/ProfileModel.dart';
import 'package:worka/phoenix/model/ReviewTags.dart';
import 'package:worka/phoenix/model/SearchModel.dart';
import 'package:worka/phoenix/model/SeeMore.dart';
import 'package:worka/phoenix/model/UserResponse.dart';
import 'package:get/get.dart';
import 'package:worka/phoenix/model/noreply_data.dart';
import 'package:worka/screens/main_screens/main_nav.dart';
import 'dashboard_work/Success.dart';
import 'dashboard_work/profile.dart';
import 'model/Constant.dart';
import 'package:dio/dio.dart' as form_data;

class Controller extends ChangeNotifier {
  var counter = 1;
  bool isSkillsLoading = false;
  String selectionPage = 'description';
  String token = '';
  String type = '';
  bool isCertificate = false;
  int homePage = 0;
  List<ReviewTags> tags = [];
  List<SeeMore> hotSee = [];
  List<SeeMore> see = [];
  ProfileModel? profileModel;
  String privacy = '';
  String terms = '';
  bool isCurrently = false;
  List<MyJobsModel>? myJobsModel = [];
  List<SearchModel>? searchModel = [];
  List<AvailablityModel>? availabilityModel = [];
  List<ExperienceModel>? exprienceList = [];
  List<InboxModel> inboxList = [];
  List<MySkill> mySkills = [];
  List<HotAlert> hotAlert = [];
  NoReplyData? noreply;
  List<LanguageModel>? languageModel = [];
  List<EducationModel>? educationModel = [];
  bool isLoading = false;
  UserResponse? userResponse;
  JobDetails? jobDetails;
  String langLevel = 'Fluent';
  String userNames = '';
  String email = '';
  String cv = '';
  bool cvLoading = false;
  NotificationModel? notificationModel;
  String avatar = '${ROOT}media/display-picture/2/download.png';
  List<AlertNotification> alertList = [];
  var stateList =
      'Abuja Abia Adamawa Akwa Ibom Anambra Bauchi Bayelsa Benue Borno Cross River Delta Ebonyi Edo Ekiti Enugu Gombe Imo Jigawa Kaduna Kano Katsina Kebbi Kogi Kwara Lagos Nassarawa Niger Ogun Ondo Osun Oyo Plateau Rivers Sokoto Taraba Yobe Zamfara'
          .split(' ');

  var questions = [
    '1. Let’s meet you again and let us know about your core\nstrenght, past experience; In summary?',
    '2. Why did you apply fot this role and what are you bringing\non board of your’re hired?',
    '3. What is your salary expectation?',
  ];

  var answers = [
    "We are a global group of energy and petrochemical\ncompanies with more than 80,000 employees in more than\n70 countries. We use advanced technologies and take an\ninnovative approach to help build a sustainable energy future.",
    "We are a global group of energy and petrochemical\ncompanies with more than 80,000 employees in more than\n70 countries. We use advanced technologies and take an\ninnovative approach to help build a sustainable energy future.",
    "We are a global group of energy and petrochemical\ncompanies with more than 80,000 employees in more than\n70 countries. We use advanced technologies and take an\ninnovative approach to help build a sustainable energy future.",
  ];

  var richAnswer =
      '1. Let’s meet you again and let us know about your core strenght, past experience; In summary?\n\n2. Tell us what your strenght and weakness are?\n\n3. What are your past experiences regarding this job role?\n\n4. Ask Questions relating to the job role.\n\n5. Ask for renumeration range.';
  String companyPage = 'description';

  setIsSkillsLoading(b) {
    isSkillsLoading = b;
    notifyListeners();
  }

  setHomePage(int i) {
    homePage = i;
    notifyListeners();
  }

  setUserName(s) {
    userNames = s;
    notifyListeners();
  }

  setIsLoading(b) {
    isLoading = b;
    notifyListeners();
  }

  void increment(TextEditingController richTextController) {
    if (richTextController.text.trim().isNotEmpty) {
      answers[counter] = richTextController.text;
      richTextController.clear();
      if (counter < 3) counter += 1;
    }
    notifyListeners();
  }

  void getHotAlert({refreshController}) async {
    try {
      final res = await Dio().get('${ROOT}get_hot_alert/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        hotAlert =
            res.data.map<HotAlert>((json) => HotAlert.fromJson(json)).toList();
        notifyListeners();
      }
    } on SocketException {
      hotAlert = [];
    } on Exception {
      hotAlert = [];
    } finally {
      if (refreshController != null) {
        refreshController.refreshCompleted();
      }
    }
  }

  void setLang(s) {
    langLevel = s;
    notifyListeners();
  }

  void changeSelectionPage(s) {
    selectionPage = s;
    notifyListeners();
  }

  void setCompanyPage(s) {
    companyPage = s;
    notifyListeners();
  }

  void setCvLoading(b) {
    this.cvLoading = b;
    notifyListeners();
  }

  void decrement(TextEditingController richTextController) {
    if (counter > 0) {
      counter -= 1;
      richTextController.text = answers[counter];
    }
    notifyListeners();
  }

  void getRelative_JobTags() async {
    try {
      final res = await Dio().get('${ROOT}relative_job_tags/');
      if (res.statusCode == 200) {
        tags = res.data
            .map<ReviewTags>((json) => ReviewTags.fromJson(json))
            .toList();
        see = await seeMore();
        notifyListeners();
      }
    } on SocketException {}
  }

  getNotifications({ctl}) async {
    try {
      final res = await Dio().get('${ROOT}fetch_notifications',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        alertList = res.data
            .map<AlertNotification>((json) => AlertNotification.fromJson(json))
            .toList();
        notifyListeners();
      }
    } on SocketException {
      return [];
    } on Exception {
      return [];
    } finally {
      if (ctl != null) {
        ctl.refreshCompleted();
      }
    }
  }

  setEmail(String s) {
    this.email = (s).trim();
    notifyListeners();
  }

  seeMore({ctl}) async {
    try {
      final res = await Dio().get('${ROOT}fetch_jobs/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        see = res.data.map<SeeMore>((json) => SeeMore.fromJson(json)).toList();
        notifyListeners();
        return see;
      }
    } on SocketException {
      return null;
    } finally {
      myJobsModel = await getMyJobs();
      profileModel = await getprofileReview();
      cv = profileModel!.cv!;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setAvatar(preferences.getString(AVATAR) ?? '');
      email = (preferences.getString(EMAIL) ?? '').trim();
      if (ctl != null) {
        ctl.refreshCompleted();
      }
      notifyListeners();
    }
  }

  getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return '${sharedPreferences.getString(FIRSTNAME.capitalizeFirst!) ?? ''} ${sharedPreferences.getString(LASTNAME.capitalizeFirst!) ?? ''}';
  }

  getUserDetailsType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return '${sharedPreferences.getString(TYPE) ?? ''}';
  }

  Future<ProfileModel?> getprofileReview() async {
    try {
      final res = await Dio().get('${ROOT}profile_details/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        profileModel = ProfileModel.fromJson(res.data);
        setUserName('${profileModel!.firstName} ${profileModel!.lastName} ${profileModel!.otherName}');
        return profileModel;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
    }
    return profileModel;
  }

  getSearch(search) async {
    try {
      final res = await Dio().post('${ROOT}search/',
          data: {'param': '$search'},
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        searchModel = res.data
            .map<SearchModel>((json) => SearchModel.fromJson(json))
            .toList();
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
    }
  }

//=========done======================
  void addLanguage(language) async {
    try {
      setIsLoading(true);
      final res = await Dio().post('${ROOT}addlanguage/',
          data: {
            'language': '$language'.toLowerCase(),
            'level': '$langLevel'.toLowerCase()
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'Language Updated');
        Get.off(() => Success(
              'Language added...',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
    } finally {
      setIsLoading(false);
      profileModel = await getprofileReview();
      notifyListeners();
    }
  }

  //=============done===================
  Future<JobDetails?> viewJob(String job_uid) async {
    try {
      final res = await Dio().get('${ROOT}viewjob/$job_uid',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        jobDetails = JobDetails.fromJson(res.data);
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection....');
      return jobDetails;
    }
    return jobDetails;
  }

  getExperience() async {
    try {
      final res = await Dio().get('${ROOT}viewworkexperiences/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        exprienceList = res.data
            .map<ExperienceModel>((json) => ExperienceModel.fromJson(json))
            .toList();
        notifyListeners();
        return exprienceList;
      }
    } on SocketException {
      return [];
    }
  }

  getlanguages() async {
    try {
      final res = await Dio().get('${ROOT}viewlanguages/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        return res.data
            .map<LanguageModel>((json) => LanguageModel.fromJson(json))
            .toList();
      }
    } on SocketException {
      return [];
    }
  }

  getEducation() async {
    try {
      final res = await Dio().get('${ROOT}vieweducations/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        return res.data
            .map<EducationModel>((json) => EducationModel.fromJson(json))
            .toList();
      }
    } on SocketException {
      return [];
    }
  }

  //=====================GET My JOB===========================================
  Future<List<MyJobsModel>> getMyJobs() async {
    List<MyJobsModel> myJobs = [];
    try {
      final res = await Dio().get('${ROOT}get_my_job/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        myJobs = res.data
            .map<MyJobsModel>((json) => MyJobsModel.fromJson(json))
            .toList();
        return myJobs;
      }
    } on SocketException {
      return myJobs;
    }
    return myJobs;
  }

  userLogin(String email, password) async {
    this.email = (email).trim();

    try {
      final response = await Dio().post('${ROOT}auth/login/',
          data: {'password': password.trim(), 'email': email.trim()});
      if (response.statusCode == 200) {
        userResponse = UserResponse.fromMap(response.data);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setToken('${userResponse!.authToken}', '${userResponse!.user}');
        //====================================================================
        preferences.setString('token', userResponse!.authToken);
        preferences.setString(TYPE, userResponse!.user);
        preferences.setString(FIRSTNAME, userResponse!.firstname);
        preferences.setString(LASTNAME, userResponse!.lastname);
        preferences.setString(EMAIL, '$email');
        preferences.setString(AVATAR, userResponse!.dp);
        if (userResponse!.user == 'employer') {
          preferences.setString(PLAN, json.encode(userResponse!.plan.toMap()));
        }
        setAvatar(userResponse!.dp);
        setUserName('${userResponse!.firstname} ${userResponse!.lastname}');
        //====================================================================
        return 'success';
      } else if (response.statusCode == 400) {
        CustomSnack('Error', 'Unable to login. Please try again..');
        return 'error';
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection..');
      return 'error';
    } on Exception {
      return 'error';
    } finally {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getString(TYPE) != 'employer') {
        seeMore();
      }
    }
  }

   apply_now(job_uid) async {
    setIsLoading(true);
    try {
      final res = await Dio().post('${ROOT}applyjob/',
          data: {'jobid': '$job_uid'},
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        if (res.data == 'successfully applied') {
          Get.off(() => Success('Successfully Applied....', callBack: () {
                Get.offAll(() => MainNav());
              }));
        }
      } else {
        CustomSnack('Error', '${res.data}');
      }
    } on SocketException {
      CustomSnack('Error', 'Check internet Connection');
    } finally {
      seeMore();
      setIsLoading(false);
    }
  }

  Future<List<MySkill>> viewSkills() async {
    if (token != '' && type == 'employee') {
      try {
        final res = await Dio().get('${ROOT}viewskills/',
            options: Options(headers: {'Authorization': 'TOKEN $token'}));
        if (res.statusCode == 200) {
          return mySkills =
              res.data.map<MySkill>((json) => MySkill.fromJson(json)).toList();
        }
      } on SocketException {
        return mySkills;
      }
    }
    return mySkills;
  }

  addSkills(skill_name, level, exp) async {
    try {
      setIsSkillsLoading(true);
      final res = await Dio().post('${ROOT}addskill/',
          data: {
            'skill_name': '$skill_name'.toLowerCase(),
            'level': '$level'.toLowerCase(),
            'year_of_experience': '$exp'
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Skills added...',
              callBack: () => Get.back(),
            ));
        notifyListeners();
      }
    } on SocketException {
    } finally {
      getprofileReview();
      setIsSkillsLoading(false);
    }
  }

  addavailability() async {
    final res = await Dio().post('${ROOT}addavailability/',
        data: {
          'full_time': true,
          'part_time': false,
          'contract': true,
          'available': true,
        },
        options: Options(headers: {'Authorization': 'TOKEN $token'}));
    if (res.statusCode == 200) {
      print(res.data);
    }
  }

  getAvailability() async {
    try {
      final res = await Dio().get('${ROOT}viewavailabilities/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        return res.data
            .map<AvailablityModel>((json) => AvailablityModel.fromJson(json))
            .toList();
      }
    } on SocketException {
      return [];
    }
  }

  cvPreview() async {
    final res = await Dio().get('${ROOT}cv_preview/',
        options: Options(headers: {'Authorization': 'TOKEN $token'}));
    if (res.statusCode == 200) {
      return ApplyDetails.fromJson(res.data);
    }
  }

  Future<List<InboxModel>> getInbox({refreshController}) async {
    try {
      final res = await Dio().get('${ROOT}chat/get_my_channels/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        inboxList = res.data
            .map<InboxModel>((json) => InboxModel.fromJson(json))
            .toList();
        notifyListeners();
        return inboxList;
      }
    } on SocketException {
      return inboxList;
    } on Exception {
      return inboxList;
    } finally {
      if (refreshController != null) refreshController.refreshCompleted();
    }
    return inboxList;
  }

  getNoReplyMessage(chat_uid, RefreshController refreshController) async {
    noreply = null;
    try {
      final res = await Dio().get('${ROOT}chat/read_chats/$chat_uid',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        noreply = NoReplyData.fromMap(res.data);
        notifyListeners();
      }
    } on SocketException {
    } on Exception {
    } finally {
      // ignore: unnecessary_null_comparison
      if (refreshController != null) refreshController.refreshCompleted();
    }
  }

  //=================================ProFile===================================
  uploadImage(String path) async {
    try {
      form_data.FormData form = form_data.FormData.fromMap({
        "display_picture": await form_data.MultipartFile.fromFile(path,
            filename: path.split('/').last)
      });
      final res = await Dio().post('${ROOT}display_picture/',
          data: form,
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        print(res.data);
        setAvatar('${res.data['response']}');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(AVATAR, '${res.data['response']}');
      }
    } on SocketException {
    } on Exception {}
  }

  uploadCV(String path, BuildContext c) async {
    try {
      setCvLoading(true);
      form_data.FormData form = form_data.FormData.fromMap({
        "cv_file": await form_data.MultipartFile.fromFile(path,
            filename: path.split('/').last)
      });
      final res = await Dio().post('${ROOT}upload_cv/',
          data: form,
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(CV_LINK, '${res.data['response']}');
        cv = '${res.data['response']}';
        Get.to(() =>
            Success('CV uploaded successfully...', callBack: () => Get.back()));
      }
    } on SocketException {
    } on Exception {
    } finally {
      setCvLoading(false);
    }
  }

  uploadCompanyImage(String path) async {
    try {
      form_data.FormData form = form_data.FormData.fromMap({
        "company_logo": await form_data.MultipartFile.fromFile(path,
            filename: path.split('/').last)
      });
      final res = await Dio().post('${ROOT}company_logo/',
          data: form,
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        print(res.data);
        setAvatar('${res.data}');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(AVATAR, '${res.data}');
      }
    } on SocketException {
    } on Exception {}
  }

  //================================Custom=====================================
  void execute() async {
    //================================EMPLOYEE REGISTRATION=======================================
    //   final res =
    //       await Dio().post('http://api.workanetworks.com/addemployee/', data: {
    //     'email': 'phoenixk544@gmail.com',
    //     'first_name': 'raphael',
    //     'last_name': 'solomon',
    //     'phone': '09067618760',
    //     'gender': 'male',
    //     'password': 'darkseids',
    //     're_password': 'darkseids',
    //     'other_name': 'chigzy'
    //   });
    //   if (res.statusCode == 201) {
    //     if (res.data['response'] == 'successful') {
    //       debugPrint('Good');
    //     }
    //   }
    // }

    // //=================================ADD SKILLS========================================
    // final res = await Dio().post('http://api.workanetworks.com/addskill/', data: {
    //   'skill_name': 'web designer',
    //   'level': 'senior',
    //   'year_of_experience': 5
    // }, options: Options(headers: {'AUTHORIZATION': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'}));
    // if(res.statusCode == 201){
    //   print(res.data);
    // }

    //=================================GET SKILLS========================================
    // final res = await Dio().get('http://api.workanetworks.com/viewskills/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   List<MySkill> skills = res.data.map<MySkill>((json)=> MySkill.fromJson(json)).toList();
    //   print(skills.length);
    // }

    //===============================ADD EXPERIENCE===========================================
    // final res = await Dio().post(
    //     'http://api.workanetworks.com/addworkexperince/',
    //     data: {
    //       'title':'software developer',
    //       'company_name': 'aptech computer education',
    //       'current': false
    //     },
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    // }

    //=================================GET EXPERIENCES========================================
    // final res = await Dio().get('http://api.workanetworks.com/viewworkexperiences/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   List<MySkill> skills = res.data.map<MySkill>((json)=> MySkill.fromJson(json)).toList();
    //   print(skills.length);
    // }

    //=====================GET My JOB===========================================
    // final res = await Dio().get('http://api.workanetworks.com/get_my_job/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   print(res.data);
    // }

    //=====================GET Position===========================================
    // final res = await Dio().get('http://api.workanetworks.com/get_positions/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   List<String> positions = res.data.map<String>((json) => json['position']).toList();
    // }

    //=====================GET INDUStries===========================================
    // final res = await Dio().get('http://api.workanetworks.com/get_industries/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   List<String> industries = res.data.map<String>((json) => json['industry']).toList();
    // }

    // //============================ VIEW AVAILABLITIES ==================================

    //============================ ADD AVAILABLITIES ==================================
    // final res = await Dio().post(
    //     'http://api.workanetworks.com/addavailability/',
    //     data: {
    //       'full_time': true,
    //       'part_time': false,
    //       'contract': true,
    //       'available': true,
    //     },
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   print(res.data);
    // }

    //============================check tags==============================================
    // final res = await Dio().post(
    //         'http://api.workanetworks.com/checktags/',
    //         data: {
    //           'content': 'Description  The Medical Sieve Group in Cognitive Computing Foundations Department at IBM Research - Almaden is looking for candidates in biomedical and clinical informatics for a new long term research project combining clinical and imaging data for enhancing clinical decision making in radiology, cardiology and other modalities.',
    //         },
    //         options: Options(headers: {
    //           'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //         }));
    //     if (res.statusCode == 200) {
    //       CheckTags checkTags = CheckTags.fromJson(res.data);
    //     }

    //============================get posted jobs==============================================
    // final res = await Dio().post(
    //     'http://api.workanetworks.com/get_posted_jobs/',
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   print(res.data);
    // }

    //============================POST JOB==============================================
    // final res = await Dio().post(
    //     'http://api.workanetworks.com/postjob/',
    //     data: {
    //       'title': 'Data Engineer',
    //       'description': desc,
    //       'qualification': qualification,
    //       'Benefit': 'Attractive salary\nExperience',
    //       'categories': 'Information Technology',
    //       'job_type': 'full time',
    //       'tags': tags.toString(),
    //       'budget_start': 'NGN ${400000}',
    //       'budget_end': 'NGN ${500000}',
    //       'is_remote': true,
    //       'location': 'Ibadan, Nigeria',
    //       'access': 'public',
    //       'expiry': '2021-12-30',
    //       'requirement': requirement
    //     },
    //     options: Options(headers: {
    //       'Authorization': 'TOKEN 928f792eaf376afda3e908390924295f08e13b10'
    //     }));
    // if (res.statusCode == 200) {
    //   print(res.data);
    // }
    //==========================================================================
    // final res = await Dio().post('http://api.workanetworks.com/addemployer/',
    //     data: {
    //       'email': 'example@yahoo.com',
    //       'first_name': 'uchiha',
    //       'last_name': 'madara',
    //       'company_name': 'IBM',
    //       'phone': '09067618877',
    //       'location': 'Ibadan',
    //       'password': 'darkseid',
    //       're_password': 'darkseid',
    //       'account_type': 'employee',
    //       'position': 'manager',
    //       'business_scale': 'medium',
    //       'company_email': 'empl1@workmail.com',
    //       'company_website': 'https://www.empl1.com',
    //     },
    //     options: Options(headers: {'Authorization': 'TOKEN $token'}));
    // if (res.statusCode == 200) {
    //   final newEmployee = NewEmployee.fromJson(res.data);
    // }
  }

  void setToken(t, type) {
    this.token = t;
    this.type = type;
    notifyListeners();
  }

  void setCurrently(bool? b) {
    isCurrently = b!;
    notifyListeners();
  }

  void setAvatar(String s) {
    avatar = s;
    notifyListeners();
  }

  updateProfile(String fName, String lName, String oName, String location,
      String about, String phone) async {
    try {
      setIsLoading(true);
      final res = await Dio().post('${ROOT}employeedetails/',
          data: {
            'uid': profileModel!.uid.toString(),
            'first_name': fName,
            'last_name': lName,
            'other_name': oName,
            'location': location,
            'about': about,
            'phone': phone.toString(),
            'gender': profileModel!.gender.toString(),
            'display_picture': profileModel!.displayPicture.toString(),
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Profile updated...',
              callBack: () => Get.off(() => ProfileScreen()),
            ));
        notifyListeners();
      }
    } on SocketException {
    } on Exception {
    } finally {
      setIsLoading(false);
      getprofileReview();
    }
  }

  void updateSkills(int? id, String title, String lvl, String year) async {
    setIsLoading(true);
    try {
      final res = await Dio().post('${ROOT}skilldetails/id',
          data: {
            'skill_name': title,
            'level': lvl,
            'year_of_experience': year,
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        print(res.data);
        CustomSnack('Error', 'Skills updated..');
      } else {
        CustomSnack('Error', 'Could not update..');
        Get.to(() => Success(
              'Skills update...',
              callBack: () => Get.off(() => ProfileScreen()),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection..');
    } finally {
      setIsLoading(false);
      profileModel = await getprofileReview();
      notifyListeners();
    }
  }

  void updateEducation(int? id, String title, String lvl, String year) async {
    setIsLoading(true);
    try {
      final res = await Dio().post('${ROOT}skilldetails/id',
          data: {
            'skill_name': title,
            'level': lvl,
            'year_of_experience': year,
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'Skills updated..');
        Get.to(() => Success(
              'Education updated...',
              callBack: () => Get.off(() => ProfileScreen()),
            ));
      } else {
        CustomSnack('Error', 'Could not update..');
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection..');
    } finally {
      setIsLoading(false);
      profileModel = await getprofileReview();
      notifyListeners();
    }
  }

  void updateExperience(int? id, String title, String lvl, String year) async {
    setIsLoading(true);
    try {
      final res = await Dio().post('${ROOT}skilldetails/id',
          data: {
            'skill_name': title,
            'level': lvl,
            'year_of_experience': year,
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'Skills updated..');
        Get.to(() => Success(
              'Experience updated...',
              callBack: () => Get.off(() => ProfileScreen()),
            ));
      } else {
        CustomSnack('Error', 'Could not update..');
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection..');
    } finally {
      setIsLoading(false);
      profileModel = await getprofileReview();
      notifyListeners();
    }
  }

  void updateLanguage(int? id, String title, String lvl, String year) async {
    setIsLoading(true);
    try {
      final res = await Dio().post('${ROOT}skilldetails/id',
          data: {
            'skill_name': title,
            'level': lvl,
            'year_of_experience': year,
          },
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        CustomSnack('Success', 'Language updated..');
        Get.to(() => Success(
              'Language updated...',
              callBack: () => Get.off(() => ProfileScreen()),
            ));
      } else {
        CustomSnack('Error', 'Could not update..');
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection..');
    } finally {
      setIsLoading(false);
      profileModel = await getprofileReview();
      notifyListeners();
    }
  }

  void logout() {
    alertList.clear();
    isLoading = false;
    jobDetails = null;
    langLevel = 'Fluent';
    userNames = '';
    isCurrently = false;
    myJobsModel = [];
    searchModel = [];
    availabilityModel = [];
    exprienceList = [];
    inboxList = [];
    mySkills = [];
    hotAlert = [];
    languageModel = [];
    educationModel = [];
    counter = 1;
    isSkillsLoading = false;
    selectionPage = 'description';
    token = '';
    type = '';
    isCertificate = false;
    homePage = 0;
    tags = [];
    see = [];
    profileModel = null;
    isCurrently = false;
    notifyListeners();
  }

  setPrivacy(String value) {
    this.privacy = value;
  }

  setTerm(String value) {
    this.terms = value;
  }

  void deleteAlert(index) {
    this.alertList.remove(index);
    notifyListeners();
  }

  Future<NotificationModel?> fetchNotifications({ctl}) async {
    try {
      final res = await Dio().get('${ROOT}notification_settings/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(res.data);
      }
    } on SocketException {
      CustomSnack('Error', 'check internet connection');
    } on Exception {
      CustomSnack('Error', 'unable to fetch notifications');
    } finally {
      if (ctl != null) {
        ctl.refreshCompleted();
      }
    }
    return notificationModel;
  }

  void setSeeMore(List<SeeMore> seeMore) {
    see.clear();
  }

  Future<List<SeeMore>> hotListJobs() async {
    try {
      final res = await Dio().get('${ROOT}hot_jobs/',
          options: Options(headers: {'Authorization': 'TOKEN $token'}));
      if (res.statusCode == 200) {
        hotSee =
            res.data.map<SeeMore>((json) => SeeMore.fromJson(json)).toList();
      }
    } on SocketException {
      CustomSnack('Error', 'check internet connection');
      return hotSee;
    } on Exception {
      CustomSnack('Error', 'unable to fetch Hot Jobs');
      return hotSee;
    }
    return hotSee;
  }
}
