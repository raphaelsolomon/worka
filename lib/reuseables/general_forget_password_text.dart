import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

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
            style: GoogleFonts.lato(color: DEFAULT_COLOR, fontSize: 13.5),
          ),
        ),
      ),
    );
  }
}
