class LanguageModel {
  LanguageModel({
    required this.id,
    required this.language,
    required this.level,
  });
  late final int id;
  late final String language;
  late final String level;

  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['language'] = language;
    _data['level'] = level;
    return _data;
  }
}
