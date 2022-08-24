// To parse this JSON data, do
//
//     final reviewTags = reviewTagsFromJson(jsonString);

import 'dart:convert';

List<ReviewTags> reviewTagsFromJson(String str) => List<ReviewTags>.from(json.decode(str).map((x) => ReviewTags.fromJson(x)));

String reviewTagsToJson(List<ReviewTags> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewTags {
  ReviewTags({
    this.tag,
  });

  String? tag;

  factory ReviewTags.fromJson(Map<String, dynamic> json) => ReviewTags(
    tag: json["tag"],
  );

  Map<String, dynamic> toJson() => {
    "tag": tag,
  };
}
