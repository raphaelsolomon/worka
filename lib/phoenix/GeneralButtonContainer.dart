import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralButtonContainer extends StatelessWidget {
  const GeneralButtonContainer(
      {required this.name,
      required this.onPress,
      required this.color,
      required this.textColor,
      required this.paddingLeft,
      required this.paddingTop,
      required this.paddingRight,
      required this.paddingBottom,
      this.radius = 8.0});

  final String name;
  final VoidCallback onPress;
  final double paddingLeft;
  final Color color;
  final Color textColor;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20.0, paddingTop, 20.0, paddingBottom),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xFF1B6DF9).withOpacity(.2), width: 1),
              borderRadius: BorderRadius.circular(radius),
              color: color),
          child: Text(
            name,
            style: GoogleFonts.lato(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
