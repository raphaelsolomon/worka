// To parse this JSON data, do
//
//     final scriptModel = scriptModelFromMap(jsonString);

import 'dart:convert';

ScriptModel scriptModelFromMap(String str) => ScriptModel.fromMap(json.decode(str));

String scriptModelToMap(ScriptModel data) => json.encode(data.toMap());

class ScriptModel {
    ScriptModel({
        required this.qAndA,
        required this.percent,
    });

    List<QAndA> qAndA;
    int percent;

    factory ScriptModel.fromMap(Map<String, dynamic> json) => ScriptModel(
        qAndA: List<QAndA>.from(json["q_and_a"].map((x) => QAndA.fromMap(x))),
        percent: json["percent"],
    );

    Map<String, dynamic> toMap() => {
        "q_and_a": List<dynamic>.from(qAndA.map((x) => x.toMap())),
        "percent": percent,
    };
}

class QAndA {
    QAndA({
        required this.question,
        required this.answer,
        required this.status,
    });

    Question question;
    String answer;
    String status;

    factory QAndA.fromMap(Map<String, dynamic> json) => QAndA(
        question: Question.fromMap(json["question"]),
        answer: json["answer"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "question": question.toMap(),
        "answer": answer,
        "status": status,
    };
}

class Question {
    Question({
        required this.question,
    });

    String question;

    factory Question.fromMap(Map<String, dynamic> json) => Question(
        question: json["question"],
    );

    Map<String, dynamic> toMap() => {
        "question": question,
    };
}
