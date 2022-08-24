// To parse this JSON data, do
//
//     final interviewTheory = interviewTheoryFromJson(jsonString);

import 'dart:convert';

InterviewTheory interviewTheoryFromJson(String str) =>
    InterviewTheory.fromJson(json.decode(str));

String interviewTheoryToJson(InterviewTheory data) =>
    json.encode(data.toJson());

class InterviewTheory {
  InterviewTheory(
      {this.interviewUid,
      this.title,
      this.note,
      this.status,
      this.startDate,
      this.endDate,
      this.timer,
      this.timerSec,
      this.interviewType,
      this.theoryInterviewQuestion,
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
  bool? submitted;
  List<TheoryInterviewQuestion>? theoryInterviewQuestion;

  factory InterviewTheory.fromJson(Map<String, dynamic> json) =>
      InterviewTheory(
        interviewUid: json["interview_uid"],
        title: json["title"],
        note: json["note"],
        status: json["status"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        timer: json["timer"],
        timerSec: json["timer_sec"],
        interviewType: json["interview_type"],
        theoryInterviewQuestion: List<TheoryInterviewQuestion>.from(
            json["theory_interview_question"]
                .map((x) => TheoryInterviewQuestion.fromJson(x))),
        submitted: json["submitted"],
      );

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
        "theory_interview_question":
            List<dynamic>.from(theoryInterviewQuestion!.map((x) => x.toJson())),
        "submitted": submitted,
      };
}

class TheoryInterviewQuestion {
  TheoryInterviewQuestion({this.questionUid, this.question, this.sub_answer});

  String? questionUid;
  String? question;
  String? sub_answer;

  factory TheoryInterviewQuestion.fromJson(Map<String, dynamic> json) =>
      TheoryInterviewQuestion(
          questionUid: json["question_uid"],
          question: json["question"],
          sub_answer: json["sub_answer"]);

  Map<String, dynamic> toJson() => {
        "question_uid": questionUid,
        "question": question,
        "sub_answer": sub_answer
      };
}
