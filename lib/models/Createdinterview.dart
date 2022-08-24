// To parse this JSON data, do
//
//     final createdinterview = createdinterviewFromMap(jsonString);

import 'dart:convert';

Createdinterview createdinterviewFromMap(String str) => Createdinterview.fromMap(json.decode(str));

String createdinterviewToMap(Createdinterview data) => json.encode(data.toMap());

class Createdinterview {
    Createdinterview({
        this.id,
        this.interviewUid,
        this.title,
        this.note,
        this.status,
        required this.startDate,
        required this.endDate,
        this.timer,
        this.submission,
        this.timerSec,
        this.interviewType,
        required this.created,
    });

    int? id;
    String? interviewUid;
    String? title;
    String? note;
    String? status;
    DateTime startDate;
    DateTime endDate;
    bool? timer;
    int? submission;
    int? timerSec;
    String? interviewType;
    DateTime created;

    factory Createdinterview.fromMap(Map<String, dynamic> json) => Createdinterview(
        id: json["id"],
        interviewUid: json["interview_uid"],
        title: json["title"],
        note: json["note"],
        status: json["status"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        timer: json["timer"],
        submission: json["submission"],
        timerSec: json["timer_sec"],
        interviewType: json["interview_type"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "interview_uid": interviewUid,
        "title": title,
        "note": note,
        "status": status,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "timer": timer,
        "submission": submission,
        "timer_sec": timerSec,
        "interview_type": interviewType,
        "created": created.toIso8601String(),
    };
}