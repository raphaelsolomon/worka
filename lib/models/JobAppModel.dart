// To parse this JSON data, do
//
//     final JobAppModel = JobAppModelFromJson(jsonString);

import 'dart:convert';

JobAppModel JobAppModelFromJson(String str) => JobAppModel.fromJson(json.decode(str));

String JobAppModelToJson(JobAppModel data) => json.encode(data.toJson());

class JobAppModel {
    JobAppModel({
        this.applications,
        this.maxChoices,
    });

    List<Application>? applications;
    int? maxChoices;

    factory JobAppModel.fromJson(Map<String, dynamic> json) => JobAppModel(
        applications: List<Application>.from(json["applications"].map((x) => Application.fromJson(x))),
        maxChoices: json["max_choices"],
    );

    Map<String, dynamic> toJson() => {
        "applications": List<dynamic>.from(applications!.map((x) => x.toJson())),
        "max_choices": maxChoices,
    };
}

class Application {
    Application({
        this.applicant,
        this.isNew,
    });

    Applicant? applicant;
    bool? isNew;

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        applicant: Applicant.fromJson(json["applicant"]),
        isNew: json["is_new"],
    );

    Map<String, dynamic> toJson() => {
        "applicant": applicant!.toJson(),
        "is_new": isNew,
    };
}

class Applicant {
    Applicant({
        this.uid,
        this.firstName,
        this.lastName,
        this.otherName,
        this.about,
        this.gender,
        this.displayPicture,
        this.location,
        this.ischecked = false,
    });

    String? uid;
  String? firstName;
  String? lastName;
  String? otherName;
  String? about;
  String? gender;
  String? displayPicture;
  String? location;
  bool? ischecked;

    factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        otherName: json["other_name"],
        about: json["about"],
        gender: json["gender"],
        displayPicture: json["display_picture"],
        location: json["location"],
        ischecked: json["ischecked"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "other_name": otherName,
        "about": about,
        "gender": gender,
        "display_picture": displayPicture,
        "location": location,
        "ischecked": ischecked,
    };
}

