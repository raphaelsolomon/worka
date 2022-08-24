// To parse this JSON data, do
//
//     final interviewObj = interviewObjFromJson(jsonString);

import 'dart:convert';

InterviewObj interviewObjFromJson(String str) =>
    InterviewObj.fromJson(json.decode(str));

String interviewObjToJson(InterviewObj data) => json.encode(data.toJson());

class InterviewObj {
  InterviewObj(
      {this.interviewUid,
      this.title,
      this.note,
      this.status,
      this.startDate,
      this.endDate,
      this.timer,
      this.timerSec,
      this.interviewType,
      this.objInterviewQuestion,
      this.submitted});

  String? interviewUid;
  String? title;
  String? note;
  String? status;
  DateTime? startDate;
  DateTime? endDate;
  bool? timer;
  int? timerSec;
  String? interviewType;
  List<ObjInterviewQuestion>? objInterviewQuestion;
  bool? submitted;

  factory InterviewObj.fromJson(Map<String, dynamic> json) => InterviewObj(
      interviewUid: json["interview_uid"],
      title: json["title"],
      note: json["note"],
      status: json["status"],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      timer: json["timer"],
      timerSec: json["timer_sec"],
      interviewType: json["interview_type"],
      objInterviewQuestion: List<ObjInterviewQuestion>.from(
          json["obj_interview_question"]
              .map((x) => ObjInterviewQuestion.fromJson(x))),
      submitted: json["submitted"]);

  Map<String, dynamic> toJson() => {
        "interview_uid": interviewUid,
        "title": title,
        "note": note,
        "status": status,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "timer": timer,
        "timer_sec": timerSec,
        "interview_type": interviewType,
        "obj_interview_question":
            List<dynamic>.from(objInterviewQuestion!.map((x) => x.toJson())),
        "submitted": submitted
      };
}

class ObjInterviewQuestion {
  ObjInterviewQuestion({
    this.questionUid,
    this.question,
    this.options,
    this.sub_answer = '',
  });

  String? questionUid;
  String? question;
  String? options;
  String sub_answer;

  setSubAnswer(String s) {
    this.sub_answer = s;
  }

  factory ObjInterviewQuestion.fromJson(Map<String, dynamic> json) =>
      ObjInterviewQuestion(
          questionUid: json["question_uid"],
          question: json["question"],
          options: json["options"],
          sub_answer: json["sub_answer"]);

  Map<String, dynamic> toJson() => {
        "question_uid": questionUid,
        "question": question,
        "options": options,
        "sub_answer": sub_answer
      };
}
