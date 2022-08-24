// To parse this JSON data, do
//
//     final newEmployee = newEmployeeFromJson(jsonString);

import 'dart:convert';

NewEmployee newEmployeeFromJson(String str) => NewEmployee.fromJson(json.decode(str));

String newEmployeeToJson(NewEmployee data) => json.encode(data.toJson());

class NewEmployee {
  NewEmployee({
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
  DateTime? created;
  int? user;

  factory NewEmployee.fromJson(Map<String, dynamic> json) => NewEmployee(
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
    "created": created!.toIso8601String(),
    "user": user,
  };
}
