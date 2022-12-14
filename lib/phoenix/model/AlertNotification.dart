// To parse this JSON data, do
//
//     final alertNotification = alertNotificationFromJson(jsonString);

import 'dart:convert';

List<AlertNotification> alertNotificationFromJson(String str) =>
    List<AlertNotification>.from(
        json.decode(str).map((x) => AlertNotification.fromJson(x)));

String alertNotificationToJson(List<AlertNotification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertNotification {
  AlertNotification({
    this.id,
    this.title,
    this.message,
    this.isRead,
    this.nType,
    required this.created,
  });

  int? id;
  String? title;
  String? message;
  bool? isRead;
  String? nType;
  late DateTime created;

  factory AlertNotification.fromJson(Map<String, dynamic> json) =>
      AlertNotification(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        isRead: json["is_read"],
        nType: json["n_type"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "is_read": isRead,
        "n_type": nType,
        "created": created.toIso8601String(),
      };
}
