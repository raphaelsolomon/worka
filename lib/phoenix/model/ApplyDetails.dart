class ApplyDetails {
  ApplyDetails({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.about,
    required this.gender,
    required this.location,
    required this.skill,
    required this.workExperience,
    required this.education,
    required this.language,
  });
  late final String uid;
  late final String firstName;
  late final String lastName;
  late final String otherName;
  late final String about;
  late final String gender;
  late final String location;
  late final List<Skill> skill;
  late final List<WorkExperience> workExperience;
  late final List<Education> education;
  late final List<Language> language;

  ApplyDetails.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    otherName = json['other_name'];
    about = json['about'];
    gender = json['gender'];
    location = json['location'] != null ? json['location'] : '';
    skill = List.from(json['skill']).map((e) => Skill.fromJson(e)).toList();
    workExperience = List.from(json['work_experience'])
        .map((e) => WorkExperience.fromJson(e))
        .toList();
    education =
        List.from(json['education']).map((e) => Education.fromJson(e)).toList();
    language =
        List.from(json['language']).map((e) => Language.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['other_name'] = otherName;
    _data['about'] = about;
    _data['gender'] = gender;
    _data['location'] = location;
    _data['skill'] = skill.map((e) => e.toJson()).toList();
    _data['work_experience'] = workExperience.map((e) => e.toJson()).toList();
    _data['education'] = education.map((e) => e.toJson()).toList();
    _data['language'] = language.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Skill {
  Skill({
    required this.skillName,
    required this.level,
    required this.yearOfExperience,
  });
  late final String skillName;
  late final String level;
  late final String yearOfExperience;

  Skill.fromJson(Map<String, dynamic> json) {
    skillName = json['skill_name'];
    level = json['level'];
    yearOfExperience = json['year_of_experience'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['skill_name'] = skillName;
    _data['level'] = level;
    _data['year_of_experience'] = yearOfExperience;
    return _data;
  }
}

class WorkExperience {
  WorkExperience({
    required this.title,
    required this.companyName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.current,
  });
  late final String title;
  late final String companyName;
  late final String description;
  late final String startDate;
  late final String endDate;
  late final bool current;

  WorkExperience.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    companyName = json['company_name'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['company_name'] = companyName;
    _data['description'] = description;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['current'] = current;
    return _data;
  }
}

class Education {
  Education({
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

  Education.fromJson(Map<String, dynamic> json) {
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

class Language {
  Language({
    required this.id,
    required this.language,
    required this.level,
  });
  late final int id;
  late final String language;
  late final String level;

  Language.fromJson(Map<String, dynamic> json) {
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
