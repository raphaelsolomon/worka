// To parse this JSON data, do
//
//     final mySkill = mySkillFromJson(jsonString);

import 'dart:convert';

List<MySkill> mySkillFromJson(String str) =>
    List<MySkill>.from(json.decode(str).map((x) => MySkill.fromJson(x)));

String mySkillToJson(List<MySkill> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MySkill {
  MySkill({
    this.id,
    this.skillName,
    this.level,
    this.yearOfExperience,
    this.numberOfSkills,
  });

  int? id;
  String? skillName;
  String? level;
  String? yearOfExperience;
  int? numberOfSkills;

  factory MySkill.fromJson(Map<String, dynamic> json) => MySkill(
        id: json["id"],
        skillName: json["skill_name"] == null ? null : json["skill_name"],
        level: json["level"] == null ? null : json["level"],
        yearOfExperience: json["year_of_experience"] == null
            ? null
            : json["year_of_experience"],
        numberOfSkills:
            json["number_of_skills"] == null ? null : json["number_of_skills"],
      );

  Map<String, dynamic> toJson() => {
        "skill_name": skillName == null ? null : skillName,
        "level": level == null ? null : level,
        "year_of_experience":
            yearOfExperience == null ? null : yearOfExperience,
        "number_of_skills": numberOfSkills == null ? null : numberOfSkills,
      };
}
