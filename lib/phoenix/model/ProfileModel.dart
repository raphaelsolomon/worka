class ProfileModel {
  User? user;
  String? uid;
  String? firstName;
  String? lastName;
  String? phone;
  String? otherName;
  String? location;
  String? about;
  String? gender;
  String? displayPicture;
  String? dateOfBirth;
  String? cv;
  String? profileSummary;
  String? keySkills;
  String? resumeHeadline;
  List<Skill>? skill;
  List<WorkExperience>? workExperience;
  List<Education>? education;
  List<Certificate>? certificate;
  List<Language>? language;
  List<Availability>? availability;

  ProfileModel(
      {this.user,
      this.uid,
      this.firstName,
      this.lastName,
      this.phone,
      this.otherName,
      this.location,
      this.about,
      this.gender,
      this.displayPicture,
      this.dateOfBirth,
      this.cv,
      this.profileSummary,
      this.keySkills,
      this.resumeHeadline,
      this.skill,
      this.workExperience,
      this.education,
      this.certificate,
      this.language,
      this.availability});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    otherName = json['other_name'];
    location = json['location'];
    about = json['about'];
    gender = json['gender'];
    displayPicture = json['display_picture'];
    dateOfBirth = json['date_of_birth'];
    cv = json['cv'];
    profileSummary = json['profile_summary'];
    keySkills = json['key_skills'];
    resumeHeadline = json['resume_headline'];
    if (json['skill'] != null) {
      skill = <Skill>[];
      json['skill'].forEach((v) {
        skill!.add(new Skill.fromJson(v));
      });
    }
    if (json['work_experience'] != null) {
      workExperience = <WorkExperience>[];
      json['work_experience'].forEach((v) {
        workExperience!.add(new WorkExperience.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    if (json['certificate'] != null) {
      certificate = <Certificate>[];
      json['certificate'].forEach((v) {
        certificate!.add(new Certificate.fromJson(v));
      });
    }
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(new Language.fromJson(v));
      });
    }
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['uid'] = this.uid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['other_name'] = this.otherName;
    data['location'] = this.location;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['display_picture'] = this.displayPicture;
    data['date_of_birth'] = this.dateOfBirth;
    data['cv'] = this.cv;
    data['profile_summary'] = this.profileSummary;
    data['key_skills'] = this.keySkills;
    data['resume_headline'] = this.resumeHeadline;
    if (this.skill != null) {
      data['skill'] = this.skill!.map((v) => v.toJson()).toList();
    }
    if (this.workExperience != null) {
      data['work_experience'] =
          this.workExperience!.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.certificate != null) {
      data['certificate'] = this.certificate!.map((v) => v.toJson()).toList();
    }
    if (this.language != null) {
      data['language'] = this.language!.map((v) => v.toJson()).toList();
    }
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? email;

  User({this.email});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class Skill {
  int? id;
  String? skillName;
  String? level;
  String? yearOfExperience;

  Skill({this.id, this.skillName, this.level, this.yearOfExperience});

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillName = json['skill_name'];
    level = json['level'];
    yearOfExperience = json['year_of_experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skill_name'] = this.skillName;
    data['level'] = this.level;
    data['year_of_experience'] = this.yearOfExperience;
    return data;
  }
}

class WorkExperience {
  int? id;
  String? title;
  String? companyName;
  String? description;
  String? startDate;
  bool? current;

  WorkExperience(
      {this.id,
      this.title,
      this.companyName,
      this.description,
      this.startDate,
      this.current});

  WorkExperience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    companyName = json['company_name'];
    description = json['description'];
    startDate = json['start_date'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['company_name'] = this.companyName;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['current'] = this.current;
    return data;
  }
}

class Education {
  int? id;
  String? schoolName;
  String? level;
  String? certificate;
  String? course;
  bool? current;
  String? startDate;
  String? endDate;

  Education(
      {this.id,
      this.schoolName,
      this.level,
      this.certificate,
      this.course,
      this.current,
      this.startDate,
      this.endDate});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_name'] = this.schoolName;
    data['level'] = this.level;
    data['certificate'] = this.certificate;
    data['course'] = this.course;
    data['current'] = this.current;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class Certificate {
  int? id;
  String? cid;
  String? url;
  String? title;
  String? issuer;
  String? dated;

  Certificate(
      {this.id, this.cid, this.url, this.title, this.issuer, this.dated});

  Certificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cid = json['cid'];
    url = json['url'];
    title = json['title'];
    issuer = json['issuer'];
    dated = json['dated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cid'] = this.cid;
    data['url'] = this.url;
    data['title'] = this.title;
    data['issuer'] = this.issuer;
    data['dated'] = this.dated;
    return data;
  }
}

class Language {
  int? id;
  String? language;
  String? level;

  Language({this.id, this.language, this.level});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['level'] = this.level;
    return data;
  }
}

class Availability {
  int? id;
  bool? fullTime;
  bool? partTime;
  bool? contract;

  Availability({this.id, this.fullTime, this.partTime, this.contract});

  Availability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullTime = json['full_time'];
    partTime = json['part_time'];
    contract = json['contract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_time'] = this.fullTime;
    data['part_time'] = this.partTime;
    data['contract'] = this.contract;
    return data;
  }
}
