import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralContinueWith extends StatelessWidget {
  const GeneralContinueWith({Key? key, required this.input1}) : super(key: key);
  final String input1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 21),
      child: Text(
        input1,
        style:GoogleFonts.montserrat(
            fontSize: 12.0,
            letterSpacing: 1,
            color: const Color(0xffBDBDBD)),
      ),
    );
  }
}
