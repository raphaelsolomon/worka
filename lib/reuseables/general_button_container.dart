import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralButtonContainer extends StatelessWidget {
  const GeneralButtonContainer(
      {Key? key,
      required this.name,
      required this.onPress,
      required this.paddingLeft,
      required this.paddingTop,
      required this.paddingRight,
      required this.paddingBottom,
      required this.paddingWidth,
      required this.paddingHeight,
      required this.radius})
      : super(key: key);
  final String name;
  final VoidCallback onPress;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double paddingWidth;
  final double paddingHeight;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            paddingLeft, paddingTop, paddingRight, paddingBottom),
        child: Container(
          width: paddingWidth,
          height: paddingHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color(0xff0D30D9)),
          child: Text(
            name,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
