// To parse this JSON data, do
//
//     final myPosted = myPostedFromMap(jsonString);

import 'dart:convert';

List<MyPosted> myPostedFromMap(String str) =>
    List<MyPosted>.from(json.decode(str).map((x) => MyPosted.fromMap(x)));

String myPostedToMap(List<MyPosted> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MyPosted {
  MyPosted({
    this.jobKey,
    this.title,
    this.description,
    this.qualification,
    this.benefit,
    this.categories,
    this.jobType,
    this.budget,
    this.tags,
    this.isRemote,
    this.location,
    required this.expiry,
    this.access,
    this.requirement,
    this.currency,
    this.salary_type,
    this.applications,
  });

  String? jobKey;
  String? title;
  String? description;
  String? qualification;
  String? benefit;
  String? categories;
  String? jobType;
  String? budget;
  String? tags;
  bool? isRemote;
  String? location;
  late DateTime expiry;
  String? access;
  String? currency;
  String? salary_type;
  String? requirement;
  int? applications;

  factory MyPosted.fromMap(Map<String, dynamic> json) => MyPosted(
        jobKey: json["job_key"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        qualification: json["qualification"] ?? '',
        benefit: json["benefit"] ?? '',
        categories: json["categories"] ?? '',
        jobType: json["job_type"] ?? '',
        budget: json["budget"] ?? '',
        tags: json["tags"] ?? '',
        isRemote: json["is_remote"] ?? false,
        location: json["location"] ?? '',
        salary_type: json["salary_type"] ?? '',
        currency: json["currency"] ?? '',
        expiry: DateTime.parse(json["expiry"] ?? '2022-03-30'),
        access: json["access"] ?? '',
        requirement: json["requirement"] ?? '',
        applications: json["applications"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "job_key": jobKey,
        "title": title,
        "description": description,
        "qualification": qualification,
        "benefit": benefit,
        "categories": categories,
        "job_type": jobType,
        "budget": budget,
        "tags": tags,
        "is_remote": isRemote,
        "location": location,
        "expiry":
            "${expiry.year.toString().padLeft(4, '0')}-${expiry.month.toString().padLeft(2, '0')}-${expiry.day.toString().padLeft(2, '0')}",
        "access": access,
        "requirement": requirement,
        "salary_type": salary_type,
        "currency": currency,
        "applications": applications,
      };
}
