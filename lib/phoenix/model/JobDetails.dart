class JobDetails {
  JobDetails({
    required this.jobData,
    required this.applied,
  });
  late final JobData jobData;
  late final bool applied;

  JobDetails.fromJson(Map<String, dynamic> json){
    jobData = JobData.fromJson(json['job_data']);
    applied = json['applied'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['job_data'] = jobData.toJson();
    _data['applied'] = applied;
    return _data;
  }
}

class JobData {
  JobData({
    required this.employer,
    required this.jobKey,
    required this.title,
    required this.description,
    required this.isRemote,
    required this.jobType,
    required this.location,
    required this.budget,
    required this.benefit,
    required this.qualification,
    required this.requirement,
    required this.salaryType,
    required this.categories,
    required this.currency,
    required this.employerLogo,
  });
  late final Employer employer;
  late final String jobKey;
  late final String title;
  late final String description;
  late final bool isRemote;
  late final String jobType;
  late final String location;
  late final String budget;
  late final String benefit;
  late final String qualification;
  late final String requirement;
  late final String salaryType;
  late final String categories;
  late final String currency;
  late final String employerLogo;

  JobData.fromJson(Map<String, dynamic> json){
    employer = Employer.fromJson(json['employer']);
    jobKey = json['job_key'];
    title = json['title'];
    description = json['description'];
    isRemote = json['is_remote'];
    jobType = json['job_type'];
    location = json['location'];
    budget = json['budget'];
    benefit = json['benefit'] ?? '';
    qualification = json['qualification'];
    requirement = json['requirement'];
    salaryType = json['salary_type'];
    categories = json['categories'];
    currency = json['currency'];
    employerLogo = json['employer_logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer'] = employer.toJson();
    _data['job_key'] = jobKey;
    _data['title'] = title;
    _data['description'] = description;
    _data['is_remote'] = isRemote;
    _data['job_type'] = jobType;
    _data['location'] = location;
    _data['budget'] = budget;
    _data['benefit'] = benefit;
    _data['qualification'] = qualification;
    _data['requirement'] = requirement;
    _data['salary_type'] = salaryType;
    _data['categories'] = categories;
    _data['employer_logo'] = employerLogo;
    return _data;
  }
}

class Employer {
  Employer({
    required this.companyName,
    required this.companyLogo,
    required this.companyProfile,
    required this.location,
    required this.reviews,
    required this.hired,
  });
  late final String companyName;
  late final String companyLogo;
  late final String companyProfile;
  late final String location;
  late final String reviews;
  late final int hired;

  Employer.fromJson(Map<String, dynamic> json){
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    companyProfile = json['company_profile'];
    location = json['location'];
    reviews = json['reviews'];
    hired = json['hired'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['company_name'] = companyName;
    _data['company_logo'] = companyLogo;
    _data['company_profile'] = companyProfile;
    _data['location'] = location;
    _data['reviews'] = reviews;
    _data['hired'] = hired;
    return _data;
  }
}