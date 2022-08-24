// To parse this JSON data, do
//
//     final seeMore = seeMoreFromJson(jsonString);

import 'dart:convert';

List<SeeMore> seeMoreFromJson(String str) =>
    List<SeeMore>.from(json.decode(str).map((x) => SeeMore.fromJson(x)));

String seeMoreToJson(List<SeeMore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeeMore {
  SeeMore(
      {this.employer_logo,
      this.title,
      this.jobKey,
      this.description,
      this.isRemote,
      this.jobType,
      this.location,
      this.budget,
      this.salaryType,
      this.isLike = false,
      this.currency});
      
  String? employer_logo;
  String? title;
  String? jobKey;
  String? description;
  bool? isRemote;
  String? jobType;
  String? location;
  String? budget;
  String? salaryType;
  bool isLike;
  String? currency;

  factory SeeMore.fromJson(Map<String, dynamic> json) => SeeMore(
        employer_logo: json["employer_logo"],
        title: json["title"],
        jobKey: json["job_key"],
        description: json["description"],
        isRemote: json["is_remote"],
        jobType: json["job_type"],
        location: json["location"],
        budget: json["budget"],
        salaryType: json["salary_type"],
        isLike: json["is_like"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "employer_logo": employer_logo,
        "title": title,
        "job_key": jobKey,
        "description": description,
        "is_remote": isRemote,
        "job_type": jobType,
        "location": location,
        "budget_start": budget,
        "salary_type": salaryType,
        "is_like": isLike,
        "currency": currency,
      };
}
