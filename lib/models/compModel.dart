// To parse this JSON data, do
//
//     final compModel = compModelFromMap(jsonString);

import 'dart:convert';

CompModel compModelFromMap(String str) => CompModel.fromMap(json.decode(str));

String compModelToMap(CompModel data) => json.encode(data.toMap());

class CompModel {
  CompModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.companyName,
    this.companyEmail,
    this.companyWebsite,
    this.position,
    this.businessScale,
    this.industry,
    this.uid,
    this.companyLogo,
    this.companyProfile,
    this.reviews,
    this.hired,
    this.location,
    this.address,
    required this.created,
    this.user,
    this.email,
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
  String? industry;
  String? uid;
  String? companyLogo;
  String? companyProfile;
  String? reviews;
  int? hired;
  String? location;
  String? address;
  DateTime created;
  int? user;
  String? email;

  factory CompModel.fromMap(Map<String, dynamic> json) => CompModel(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        phone: json["phone"] ?? '',
        companyName: json["company_name"] ?? '',
        companyEmail: json["company_email"] ?? '',
        companyWebsite: json["company_website"] ?? '',
        position: json["position"] ?? '',
        businessScale: json["business_scale"] ?? '',
        industry: json["industry"] ?? '',
        uid: json["uid"] ?? '',
        companyLogo: json["company_logo"] ?? '',
        companyProfile: json["company_profile"] ?? '',
        reviews: json["reviews"] ?? '',
        hired: json["hired"] ?? 0,
        location: json["location"] ?? ' , , ',
        address: json["address"] ?? '',
        created: DateTime.parse(json["created"]),
        user: json["user"] ?? 0,
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "company_name": companyName,
        "company_email": companyEmail,
        "company_website": companyWebsite,
        "position": position,
        "business_scale": businessScale,
        "industry": industry,
        "uid": uid,
        "company_logo": companyLogo,
        "company_profile": companyProfile,
        "reviews": reviews,
        "hired": hired,
        "location": location,
        "address": address,
        "created": created.toIso8601String(),
        "user": user,
        "email": email,
      };
}
