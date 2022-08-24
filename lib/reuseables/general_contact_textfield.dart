import 'package:flutter/material.dart';

class GeneralContactTextField extends StatelessWidget {
  const GeneralContactTextField({Key? key, required this.controller,required this.input}) : super(key: key);
  final TextEditingController controller;
  final String input;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 16, 36.5, 0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        decoration:  InputDecoration(
            labelText: input,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Lato'),
            border: const OutlineInputBorder(),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5))),
        validator: (value){
          if(value!.isEmpty)
          {
            return "Please enter  phone";
          }
          if(value.length < 9)
          {
            return "Please enter valid phone";
          }
          return null;
        },
      ),
    );
  }
}
