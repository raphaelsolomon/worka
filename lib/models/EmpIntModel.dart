// To parse this JSON data, do
//
//     final empIntModel = empIntModelFromMap(jsonString);

import 'dart:convert';

List<EmpIntModel> empIntModelFromMap(String str) => List<EmpIntModel>.from(json.decode(str).map((x) => EmpIntModel.fromMap(x)));

String empIntModelToMap(List<EmpIntModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class EmpIntModel {
  EmpIntModel({
    required this.interviewUid,
    required this.title,
    required this.note,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.timer,
    required this.timerSec,
    required this.interviewType,
    required this.submission,
    required this.questioned,
    required this.job,
  });

  final String interviewUid;
  final String title;
  final String note;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final bool timer;
  final int timerSec;
  final String interviewType;
  final int submission;
  final bool questioned;
  final Job job;

  factory EmpIntModel.fromMap(Map<String, dynamic> json) => EmpIntModel(
    interviewUid: json["interview_uid"],
    title: json["title"],
    note: json["note"],
    status: json["status"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    timer: json["timer"],
    timerSec: json["timer_sec"],
    interviewType: json["interview_type"],
    submission: json["submission"],
    questioned: json["questioned"],
    job: Job.fromMap(json["job"]),
  );

  Map<String, dynamic> toMap() => {
    "interview_uid": interviewUid,
    "title": title,
    "note": note,
    "status": status,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "timer": timer,
    "timer_sec": timerSec,
    "interview_type": interviewType,
    "submission": submission,
    "questioned": questioned,
    "job": job.toMap(),
  };
}

class Job {
  Job({
    required this.employerLogo,
    required this.title,
    required this.budget,
  });

  final String employerLogo;
  final String title;
  final String budget;

  factory Job.fromMap(Map<String, dynamic> json) => Job(
    employerLogo: json["employer_logo"],
    title: json["title"],
    budget: json["budget"],
  );

  Map<String, dynamic> toMap() => {
    "employer_logo": employerLogo,
    "title": title,
    "budget": budget,
  };
}
