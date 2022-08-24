class SearchModel {
  SearchModel({
    required this.employerLogo,
    required this.title,
    required this.jobKey,
    required this.description,
    required this.isRemote,
    required this.jobType,
    required this.location,
    required this.budget,
    required this.salaryType,
  });
  late final String employerLogo;
  late final String title;
  late final String jobKey;
  late final String description;
  late final bool isRemote;
  late final String jobType;
  late final String location;
  late final String budget;
  late final String salaryType;

  SearchModel.fromJson(Map<String, dynamic> json) {
    employerLogo = json['employer_logo'];
    title = json['title'];
    jobKey = json['job_key'];
    description = json['description'];
    isRemote = json['is_remote'];
    jobType = json['job_type'];
    location = json['location'];
    budget = json['budget'];
    salaryType = json['salary_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer_logo'] = employerLogo;
    _data['title'] = title;
    _data['job_key'] = jobKey;
    _data['description'] = description;
    _data['is_remote'] = isRemote;
    _data['job_type'] = jobType;
    _data['location'] = location;
    _data['budget'] = budget;
    _data['salary_type'] = salaryType;
    return _data;
  }
}
