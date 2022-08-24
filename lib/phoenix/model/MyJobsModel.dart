class MyJobsModel {
  MyJobsModel({
    required this.id,
    required this.job,
    required this.status,
    required this.created,
  });
  late final int id;
  late final Job job;
  late final String status;
  late final String created;

  MyJobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = Job.fromJson(json['job']);
    status = json['status'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['job'] = job.toJson();
    _data['status'] = status;
    _data['created'] = created;
    return _data;
  }
}

class Job {
  Job({
    required this.employer,
    required this.jobKey,
    required this.title,
    required this.description,
    required this.qualification,
    required this.benefit,
    required this.categories,
    required this.jobType,
    required this.budget,
    required this.tags,
    required this.isRemote,
    required this.location,
    required this.expiry,
    required this.access,
    required this.currency,
    required this.salary_type,
    required this.requirement,
    required this.applications,
  });
  late final Employer employer;
  late final String jobKey;
  late final String title;
  late final String description;
  late final String qualification;
  late final String benefit;
  late final String categories;
  late final String jobType;
  late final String budget;
  late final String tags;
  late final bool isRemote;
  late final String location;
  late final String expiry;
  late final String access;
  late final String currency;
  late final String salary_type;
  late final String requirement;
  late final int applications;

  Job.fromJson(Map<String, dynamic> json) {
    employer = Employer.fromJson(json['employer']);
    jobKey = json['job_key'];
    title = json['title'];
    description = json['description'];
    qualification = json['qualification'];
    benefit = json['benefit'] ?? '';
    categories = json['categories'];
    jobType = json['job_type'];
    budget = json['budget'];
    tags = json['tags'] ?? '';
    isRemote = json['is_remote'];
    location = json['location'];
    expiry = json['expiry'];
    currency = json['currency'];
    access = json['access'];
    salary_type = json['salary_type'];
    requirement = json['requirement'];
    applications = json['applications'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer'] = employer.toJson();
    _data['job_key'] = jobKey;
    _data['title'] = title;
    _data['description'] = description;
    _data['qualification'] = qualification;
    _data['benefit'] = benefit;
    _data['categories'] = categories;
    _data['job_type'] = jobType;
    _data['budget'] = budget;
    _data['tags'] = tags;
    _data['is_remote'] = isRemote;
    _data['location'] = location;
    _data['expiry'] = expiry;
    _data['access'] = access;
    _data['requirement'] = requirement;
    _data['applications'] = applications;
    return _data;
  }
}

class Employer {
  Employer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.companyName,
    required this.companyEmail,
    required this.companyWebsite,
    required this.position,
    required this.businessScale,
    required this.uid,
    required this.companyLogo,
    required this.companyProfile,
    required this.reviews,
    required this.hired,
    required this.location,
    required this.address,
    required this.created,
    required this.user,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final String companyName;
  late final String companyEmail;
  late final String companyWebsite;
  late final String position;
  late final String businessScale;
  late final String uid;
  late final String companyLogo;
  late final String companyProfile;
  late final String reviews;
  late final int hired;
  late final String location;
  late final String address;
  late final String created;
  late final int user;

  Employer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyWebsite = json['company_website'];
    position = json['position'];
    businessScale = json['business_scale'];
    uid = json['uid'];
    companyLogo = json['company_logo'];
    companyProfile = json['company_profile'];
    reviews = json['reviews'];
    hired = json['hired'];
    location = json['location'];
    address = json['address'];
    created = json['created'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['phone'] = phone;
    _data['company_name'] = companyName;
    _data['company_email'] = companyEmail;
    _data['company_website'] = companyWebsite;
    _data['position'] = position;
    _data['business_scale'] = businessScale;
    _data['uid'] = uid;
    _data['company_logo'] = companyLogo;
    _data['company_profile'] = companyProfile;
    _data['reviews'] = reviews;
    _data['hired'] = hired;
    _data['location'] = location;
    _data['address'] = address;
    _data['created'] = created;
    _data['user'] = user;
    return _data;
  }
}
