import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralForgetPasswordText extends StatelessWidget {
  const GeneralForgetPasswordText(
      {Key? key, required this.input, required this.onPress})
      : super(key: key);
  final String input;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: onPress,
          child: Text(
            input,
            style: GoogleFonts.montserrat(color: const Color(0xff0D30D9), fontSize: 12),
          ),
        ),
      ),
    );
  }
}
