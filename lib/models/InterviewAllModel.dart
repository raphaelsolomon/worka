// To parse this JSON data, do
//
//     final interviewAllModel = interviewAllModelFromJson(jsonString);

import 'dart:convert';

List<InterviewAllModel> interviewAllModelFromJson(String str) =>
    List<InterviewAllModel>.from(
        json.decode(str).map((x) => InterviewAllModel.fromJson(x)));

String interviewAllModelToJson(List<InterviewAllModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterviewAllModel {
  InterviewAllModel({
    this.id,
    this.interviewUid,
    this.title,
    this.note,
    this.status,
    required this.startDate,
    required this.endDate,
    this.timer,
    this.timerSec,
    this.interviewType,
    this.job,
  });

  int? id;
  String? interviewUid;
  String? title;
  String? note;
  String? status;
  DateTime startDate;
  DateTime endDate;
  bool? timer;
  int? timerSec;
  String? interviewType;
  Job? job;

  factory InterviewAllModel.fromJson(Map<String, dynamic> json) =>
      InterviewAllModel(
        id: json["id"],
        interviewUid: json["interview_uid"],
        title: json["title"],
        note: json["note"],
        status: json["status"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        timer: json["timer"],
        timerSec: json["timer_sec"],
        interviewType: json["interview_type"],
        job: Job.fromJson(json["job"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "interview_uid": interviewUid,
        "title": title,
        "note": note,
        "status": status,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "timer": timer,
        "timer_sec": timerSec,
        "interview_type": interviewType,
        "job": job!.toJson(),
      };
}

class Job {
  Job({
    this.employerLogo,
    this.title,
    this.budget,
  });

  String? employerLogo;
  String? title;
  String? budget;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        employerLogo: json["employer_logo"],
        title: json["title"],
        budget: json["budget"],
      );

  Map<String, dynamic> toJson() => {
        "employer_logo": employerLogo,
        "title": title,
        "budget": budget,
      };
}
