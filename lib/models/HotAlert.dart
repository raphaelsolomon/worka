// To parse this JSON data, do
//
//     final hotAlert = hotAlertFromJson(jsonString);

import 'dart:convert';

List<HotAlert> hotAlertFromJson(String str) =>
    List<HotAlert>.from(json.decode(str).map((x) => HotAlert.fromJson(x)));

String hotAlertToJson(List<HotAlert> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotAlert {
  HotAlert({
    this.message,
    this.link,
  });

  String? message;
  String? link;

  factory HotAlert.fromJson(Map<String, dynamic> json) => HotAlert(
        message: json["message"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "link": link,
      };
}
