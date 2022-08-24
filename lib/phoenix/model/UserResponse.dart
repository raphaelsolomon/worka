// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';

UserResponse userResponseFromMap(String str) => UserResponse.fromMap(json.decode(str));

String userResponseToMap(UserResponse data) => json.encode(data.toMap());

class UserResponse {
    UserResponse({
        required this.authToken,
        required this.user,
        required this.firstname,
        required this.lastname,
        required this.dp,
        required this.plan,
    });

    String authToken;
    String user;
    String firstname;
    String lastname;
    String dp;
    Plan plan;

    factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        authToken: json["auth_token"],
        user: json["user"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        dp: json["dp"],
        plan: Plan.fromMap(json["plan"]),
    );

    Map<String, dynamic> toMap() => {
        "auth_token": authToken,
        "user": user,
        "firstname": firstname,
        "lastname": lastname,
        "dp": dp,
        "plan": plan.toMap(),
    };
}

class Plan {
    Plan({
        required this.name,
        required this.max,
        required this.note,
    });

    String name;
    int max;
    String note;

    factory Plan.fromMap(Map<String, dynamic> json) => Plan(
        name: json["name"],
        max: json["max"],
        note: json["note"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "max": max,
        "note": note,
    };
}
