import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralHeader extends StatefulWidget {
  const GeneralHeader(
      {Key? key,
      required this.input1,
      required this.input2,
      required this.paddingLeft,
      required this.paddingTop,
      required this.paddingBottom,
      required this.paddingRight,
      required this.paddingLeft2,
      required this.paddingTop2,
      required this.paddingRight2,
      required this.paddingBottom2})
      : super(key: key);
  final String input1;
  final String input2;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double paddingLeft2;
  final double paddingTop2;
  final double paddingRight2;
  final double paddingBottom2;

  @override
  State<GeneralHeader> createState() => _GeneralHeaderState();
}

class _GeneralHeaderState extends State<GeneralHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(widget.paddingLeft, widget.paddingTop,
              widget.paddingRight, widget.paddingBottom),
          child: Text(
            widget.input1,
            softWrap: true,
            style: GoogleFonts.montserrat(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xff0D30D9),),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(widget.paddingLeft2, widget.paddingTop2,
              widget.paddingRight2, widget.paddingBottom2),
          child: Text(
            widget.input2,
            style: GoogleFonts.montserrat(
                fontSize: 14.0,
                letterSpacing: 1,
                color: const Color(0xff4F4F4F).withOpacity(.8)),
          ),
        ),
      ],
    );
  }
}
