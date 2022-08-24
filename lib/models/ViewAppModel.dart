// To parse this JSON data, do
//
//     final viewAppModel = viewAppModelFromJson(jsonString);

import 'dart:convert';

ViewAppModel viewAppModelFromJson(String str) =>
    ViewAppModel.fromJson(json.decode(str));

String viewAppModelToJson(ViewAppModel data) => json.encode(data.toJson());

class ViewAppModel {
  ViewAppModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.otherName,
    this.about,
    this.gender,
    this.location,
    this.skill,
    this.workExperience,
    this.education,
    this.language,
  });

  String? uid;
  String? firstName;
  String? lastName;
  String? otherName;
  String? about;
  String? gender;
  String? location;
  List<Skill>? skill;
  List<WorkExperience>? workExperience;
  List<Education>? education;
  List<Language>? language;

  factory ViewAppModel.fromJson(Map<String, dynamic> json) => ViewAppModel(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        otherName: json["other_name"],
        about: json["about"],
        gender: json["gender"],
        location: json["location"],
        skill: List<Skill>.from(json["skill"].map((x) => Skill.fromJson(x))),
        workExperience: List<WorkExperience>.from(
            json["work_experience"].map((x) => WorkExperience.fromJson(x))),
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        language: List<Language>.from(
            json["language"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "other_name": otherName,
        "about": about,
        "gender": gender,
        "location": location,
        "skill": List<dynamic>.from(skill!.map((x) => x.toJson())),
        "work_experience":
            List<dynamic>.from(workExperience!.map((x) => x.toJson())),
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "language": List<dynamic>.from(language!.map((x) => x.toJson())),
      };
}

class Education {
  Education({
    this.id,
    this.schoolName,
    this.level,
    this.certificate,
    this.course,
    this.current,
    required this.startDate,
    required this.endDate,
  });

  int? id;
  String? schoolName;
  String? level;
  String? certificate;
  String? course;
  bool? current;
  late DateTime startDate;
  late DateTime endDate;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        schoolName: json["school_name"],
        level: json["level"],
        certificate: json["certificate"],
        course: json["course"],
        current: json["current"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_name": schoolName,
        "level": level,
        "certificate": certificate,
        "course": course,
        "current": current,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class Language {
  Language({
    this.id,
    this.language,
    this.level,
  });

  int? id;
  String? language;
  String? level;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        language: json["language"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "level": level,
      };
}

class Skill {
  Skill({
    this.id,
    this.skillName,
    this.level,
    this.yearOfExperience,
  });

  int? id;
  String? skillName;
  String? level;
  String? yearOfExperience;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skillName: json["skill_name"],
        level: json["level"],
        yearOfExperience: json["year_of_experience"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill_name": skillName,
        "level": level,
        "year_of_experience": yearOfExperience,
      };
}

class WorkExperience {
  WorkExperience({
    this.id,
    this.title,
    this.companyName,
    this.description,
    required this.startDate,
    required this.endDate,
    this.current,
  });

  int? id;
  String? title;
  String? companyName;
  String? description;
  late DateTime startDate;
  late DateTime endDate;
  bool? current;

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["id"],
        title: json["title"],
        companyName: json["company_name"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        current: json["current"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "company_name": companyName,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "current": current,
      };
}
