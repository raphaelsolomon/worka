import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralPasswordTextField extends StatefulWidget {
  const GeneralPasswordTextField(
      {Key? key,
      required this.passwordController,
      required this.input1,
      required this.input2})
      : super(key: key);
  final TextEditingController passwordController;
  final String input1;
  final String input2;

  @override
  State<GeneralPasswordTextField> createState() =>
      _GeneralPasswordTextFieldState();
}

class _GeneralPasswordTextFieldState extends State<GeneralPasswordTextField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin:
          const EdgeInsets.only(top: 13.0, left: 20.0, bottom: 0.0, right: 20),
      child: TextFormField(
        controller: widget.passwordController,
        style: GoogleFonts.montserrat(
            color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
        obscureText: hidePassword,
        decoration: InputDecoration(
            labelText: widget.input1,
            hintText: widget.input2,
            labelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
              color: Colors.grey,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide:
                  BorderSide(color: const Color(0xFF1B6DF9).withOpacity(.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide:
                  BorderSide(color: const Color(0xFF1B6DF9).withOpacity(.2)),
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                hidePassword = !hidePassword;
              }),
              color: Colors.black,
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
