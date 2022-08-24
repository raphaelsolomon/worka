// To parse this JSON data, do
//
//     final submittedInterview = submittedInterviewFromMap(jsonString);

import 'dart:convert';

SubmittedInterview submittedInterviewFromMap(String str) =>
    SubmittedInterview.fromMap(json.decode(str));

String submittedInterviewToMap(SubmittedInterview data) =>
    json.encode(data.toMap());

class SubmittedInterview {
  SubmittedInterview({
    this.submission,
    this.maxChoices,
  });

  final List<Submission>? submission;
  final int? maxChoices;

  factory SubmittedInterview.fromMap(Map<String, dynamic> json) =>
      SubmittedInterview(
        submission: List<Submission>.from(
            json["submission"].map((x) => Submission.fromMap(x))),
        maxChoices: json["max_choices"],
      );

  Map<String, dynamic> toMap() => {
        "submission": List<dynamic>.from(submission!.map((x) => x.toMap())),
        "max_choices": maxChoices,
      };
}

class Submission {
  Submission(
      {this.uid,
      this.firstName,
      this.lastName,
      this.location,
      this.ischecked = false});

  String? uid;
  String? firstName;
  String? lastName;
  String? location;
  bool? ischecked;

  factory Submission.fromMap(Map<String, dynamic> json) => Submission(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        location: json["location"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "location": location,
      };
}
