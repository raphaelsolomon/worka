import 'dart:convert';

CheckTags checkTagsFromJson(String str) => CheckTags.fromJson(json.decode(str));

String checkTagsToJson(CheckTags data) => json.encode(data.toJson());

class CheckTags {
  CheckTags({
    this.found,
    this.keywords,
  });

  int? found;
  List<String>? keywords;

  factory CheckTags.fromJson(Map<String, dynamic> json) => CheckTags(
    found: json["found"],
    keywords: List<String>.from(json["keywords"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "found": found,
    "keywords": List<dynamic>.from(keywords!.map((x) => x)),
  };
}
