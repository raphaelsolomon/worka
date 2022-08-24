// To parse this JSON data, do
//
//     final postedJobs = postedJobsFromJson(jsonString);

import 'dart:convert';

List<EmpPostedJobs> postedJobsFromJson(String str) => List<EmpPostedJobs>.from(
    json.decode(str).map((x) => EmpPostedJobs.fromJson(x)));

String postedJobsToJson(List<EmpPostedJobs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpPostedJobs {
  EmpPostedJobs({
    this.employer,
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
    this.expiry,
    this.access,
    this.requirement,
    this.applications,
  });

  Employer? employer;
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
  DateTime? expiry;
  String? access;
  String? requirement;
  int? applications;

  factory EmpPostedJobs.fromJson(Map<String, dynamic> json) => EmpPostedJobs(
        employer: Employer.fromJson(json["employer"]),
        jobKey: json["job_key"],
        title: json["title"],
        description: json["description"],
        qualification: json["qualification"],
        benefit: json["benefit"] == null ? "" : json["benefit"],
        categories: json["categories"],
        jobType: json["job_type"],
        budget: json["budget"],
        tags: json["tags"],
        isRemote: json["is_remote"],
        location: json["location"],
        expiry: DateTime.parse(json["expiry"]),
        access: json["access"],
        requirement: json["requirement"],
        applications: json["applications"],
      );

  Map<String, dynamic> toJson() => {
        "employer": employer!.toJson(),
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
            "${expiry!.year.toString().padLeft(4, '0')}-${expiry!.month.toString().padLeft(2, '0')}-${expiry!.day.toString().padLeft(2, '0')}",
        "access": access,
        "requirement": requirement,
        "applications": applications,
      };
}

class Employer {
  Employer({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.companyName,
    this.companyEmail,
    this.companyWebsite,
    this.position,
    this.businessScale,
    this.uid,
    this.companyLogo,
    this.companyProfile,
    this.reviews,
    this.hired,
    this.location,
    this.address,
    this.created,
    this.user,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? companyName;
  String? companyEmail;
  String? companyWebsite;
  String? position;
  String? businessScale;
  String? uid;
  String? companyLogo;
  String? companyProfile;
  String? reviews;
  int? hired;
  String? location;
  String? address;
  DateTime? created;
  int? user;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        companyName: json["company_name"],
        companyEmail: json["company_email"],
        companyWebsite: json["company_website"],
        position: json["position"],
        businessScale: json["business_scale"],
        uid: json["uid"],
        companyLogo: json["company_logo"],
        companyProfile: json["company_profile"],
        reviews: json["reviews"],
        hired: json["hired"],
        location: json["location"],
        address: json["address"],
        created: DateTime.parse(json["created"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "company_name": companyName,
        "company_email": companyEmail,
        "company_website": companyWebsite,
        "position": position,
        "business_scale": businessScale,
        "uid": uid,
        "company_logo": companyLogo,
        "company_profile": companyProfile,
        "reviews": reviews,
        "hired": hired,
        "location": location,
        "address": address,
        "created": created!.toIso8601String(),
        "user": user,
      };
}
