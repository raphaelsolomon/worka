import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool personalDetails = false;
  bool education = false;
  bool experience = false;
  bool skills = false;
  bool certificate = false;
  bool language = false;
  bool availability = false;
  bool additionalInformation = false;

  setPersonalDetails(b) {
    personalDetails = b;
    notifyListeners();
  }

   setEducation(b) {
    education = b;
    notifyListeners();
  }

   setExperience(b) {
    experience = b;
    notifyListeners();
  }

   setSkills(b) {
    skills = b;
    notifyListeners();
  }

   setCertificate(b) {
    certificate = b;
    notifyListeners();
  }

   setLanguage(b) {
    language = b;
    notifyListeners();
  }

   setAvailablity(b) {
    availability = b;
    notifyListeners();
  }

   setAdditionalInformation(b) {
    additionalInformation = b;
    notifyListeners();
  }
}
