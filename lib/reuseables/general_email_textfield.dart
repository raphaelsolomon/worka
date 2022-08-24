import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralEmailTextField extends StatefulWidget {
  GeneralEmailTextField(
      {Key? key, required this.myController, required this.name})
      : super(key: key);
  TextEditingController myController = TextEditingController();
  final String name;

  @override
  State<GeneralEmailTextField> createState() => _GeneralEmailTextFieldState();
}

class _GeneralEmailTextFieldState extends State<GeneralEmailTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 36.5, 0),
      child: TextFormField(
        controller: widget.myController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontSize: 20.0, fontFamily: 'Lato', fontWeight: FontWeight.bold),
        // validator: (email) =>
        // email != null && !EmailValidator.validate(email)
        //     ? 'Enter a valid Email'
        //     : null,
        // onChanged: (value) => {
        //   _isValid = EmailValidator.validate(value),
        // },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter  email';
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return 'Please provide a valid email';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: widget.name,
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
