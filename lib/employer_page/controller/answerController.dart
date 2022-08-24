import 'package:flutter/material.dart';

class AnswerController extends ChangeNotifier {
  Map<String?, dynamic> answer = {};

  setAnswer(id, data) {
    answer.putIfAbsent(id, () => data);
  }
}
