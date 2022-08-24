import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Helper extends ChangeNotifier {
  String gender = 'Male';

  setGender(s) {
    gender = s;
    notifyListeners();
  }
}
