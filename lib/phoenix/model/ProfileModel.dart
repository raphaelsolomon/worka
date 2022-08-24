// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.displayPicture,
      this.otherName,
      this.phone,
      this.about,
      this.gender,
      this.cv,
      this.location,
      this.user,
      this.skill,
      this.workExperience,
      this.education,
      this.language,
      this.availability});

  String? uid;
  String? firstName;
  String? lastName;
  String? displayPicture;
  String? otherName;
  String? phone;
  String? about;
  String? gender;
  String? cv;
  String? location;
  User? user;
  List<Skill>? skill;
  List<WorkExperience>? workExperience;
  List<Education>? education;
  List<Language>? language;
  List<Availability>? availability;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
      uid: json["uid"] ?? '',
      firstName: json["first_name"] ?? '',
      lastName: json["last_name"] ?? '',
      displayPicture: json["display_picture"] ?? '',
      otherName: json["other_name"] ?? '',
      phone: json["phone"] ?? '',
      about: json["about"] ?? '',
      gender: json["gender"] ?? '',
      cv: json["cv"] ?? '',
      location: json["location"] ?? 'null, null, null',
      user: User.fromMap(json["user"]),
      skill: List<Skill>.from(json["skill"].map((x) => Skill.fromMap(x))),
      workExperience: List<WorkExperience>.from(
          json["work_experience"].map((x) => WorkExperience.fromMap(x))),
      education: List<Education>.from(
          json["education"].map((x) => Education.fromMap(x))),
      language:
          List<Language>.from(json["language"].map((x) => Language.fromMap(x))),
      availability: List<Availability>.from(
          json["availability"].map((x) => Availability.fromMap(x))));

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "display_picture": displayPicture,
        "other_name": otherName,
        "phone": phone,
        "about": about,
        "gender": gender,
        "cv": cv,
        "location": location,
        "user": user!.toMap(),
        "skill": List<dynamic>.from(skill!.map((x) => x.toMap())),
        "work_experience":
            List<dynamic>.from(workExperience!.map((x) => x.toMap())),
        "education": List<dynamic>.from(education!.map((x) => x.toMap())),
        "language": List<dynamic>.from(language!.map((x) => x.toMap())),
        "availability": List<dynamic>.from(availability!.map((x) => x.toMap()))
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

  factory Education.fromMap(Map<String, dynamic> json) => Education(
        id: json["id"],
        schoolName: json["school_name"],
        level: json["level"],
        certificate: json["certificate"],
        course: json["course"],
        current: json["current"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toMap() => {
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

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        id: json["id"],
        language: json["language"],
        level: json["level"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "language": language,
        "level": level,
      };
}

class Availability {
  Availability({
    required this.id,
    required this.fullTime,
    required this.partTime,
    required this.contract,
  });

  int id;
  bool fullTime;
  bool partTime;
  bool contract;

  factory Availability.fromMap(Map<String, dynamic> json) => Availability(
        id: json["id"],
        fullTime: json["full_time"],
        partTime: json["part_time"],
        contract: json["contract"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "full_time": fullTime,
        "part_time": partTime,
        "contract": contract,
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

  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skillName: json["skill_name"],
        level: json["level"],
        yearOfExperience: json["year_of_experience"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "skill_name": skillName,
        "level": level,
        "year_of_experience": yearOfExperience,
      };
}

class User {
  User({
    this.email,
  });

  String? email;

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "email": email,
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

  factory WorkExperience.fromMap(Map<String, dynamic> json) => WorkExperience(
        id: json["id"],
        title: json["title"],
        companyName: json["company_name"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        current: json["current"],
      );

  Map<String, dynamic> toMap() => {
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
