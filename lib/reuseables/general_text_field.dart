import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralTextField extends StatefulWidget {
  GeneralTextField(
      {Key? key,
      required this.myController,
      required this.input1,
      required this.isEmail})
      : super(key: key);
  final TextEditingController myController;
  final String input1;
  bool isEmail = true;

  @override
  State<GeneralTextField> createState() => _GeneralTextFieldState();
}

class _GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 16, 36.5, 0),
      child: TextFormField(
        controller: widget.myController,
        keyboardType:
            widget.isEmail ? TextInputType.emailAddress : TextInputType.name,
        style: const TextStyle(
            fontSize: 15.0, fontFamily: 'Lato', fontWeight: FontWeight.bold),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter name";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: widget.input1,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Lato'),
            border: const OutlineInputBorder(),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5))),
      ),
    );
  }
}
