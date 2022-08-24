class EducationModel {
  EducationModel({
    required this.id,
    required this.schoolName,
    required this.level,
    required this.certificate,
    required this.course,
    required this.current,
    required this.startDate,
    required this.endDate,
  });
  late final int id;
  late final String schoolName;
  late final String level;
  late final String certificate;
  late final String course;
  late final bool current;
  late final String startDate;
  late final String endDate;
  
  EducationModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    schoolName = json['school_name'];
    level = json['level'];
    certificate = json['certificate'];
    course = json['course'];
    current = json['current'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['school_name'] = schoolName;
    _data['level'] = level;
    _data['certificate'] = certificate;
    _data['course'] = course;
    _data['current'] = current;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    return _data;
  }
}