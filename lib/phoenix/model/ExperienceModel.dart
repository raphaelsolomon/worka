class ExperienceModel {
  ExperienceModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.current,
  });
  late final int id;
  late final String title;
  late final String companyName;
  late final String description;
  late final String startDate;
  late final String endDate;
  late final bool current;

  ExperienceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    companyName = json['company_name'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['company_name'] = companyName;
    _data['description'] = description;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['current'] = current;
    return _data;
  }
}
