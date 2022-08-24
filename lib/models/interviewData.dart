// To parse this JSON data, do
//
//     final interviewData = interviewDataFromMap(jsonString);

import 'dart:convert';

InterviewData interviewDataFromMap(String str) => InterviewData.fromMap(json.decode(str));

String interviewDataToMap(InterviewData data) => json.encode(data.toMap());

class InterviewData {
    InterviewData({
        required this.id,
        required this.interviewUid,
        required this.title,
        required this.note,
        required this.status,
        required this.startDate,
        required this.endDate,
        required this.timer,
        required this.timerSec,
        required this.interviewType,
        required this.sent,
        required this.questioned,
        required this.submitted,
    });

    int id;
    String interviewUid;
    String title;
    String note;
    String status;
    DateTime startDate;
    DateTime endDate;
    bool timer;
    int timerSec;
    String interviewType;
    bool sent;
    bool questioned;
    bool submitted;

    factory InterviewData.fromMap(Map<String, dynamic> json) => InterviewData(
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
        sent: json["sent"],
        questioned: json["questioned"],
        submitted: json["submitted"],
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
        "timer_sec": timerSec,
        "interview_type": interviewType,
        "sent": sent,
        "questioned": questioned,
        "submitted": submitted,
    };
}
