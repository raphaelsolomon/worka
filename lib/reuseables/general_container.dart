import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer(
      {Key? key,
      required this.name,
      required this.onPress,
      required this.paddingLeft,
      required this.paddingTop,
      required this.paddingRight,
      required this.paddingBottom,
      required this.width,
      required this.height,
      required this.size,
      required this.stroke,
      required this.bcolor})
      : super(key: key);
  final String name;
  final VoidCallback onPress;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double width;
  final double height;
  final double size;
  final double stroke;
  final Color bcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            paddingLeft, paddingTop, paddingRight, paddingBottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: bcolor, width: stroke)),
          child: Text(
            name,
            style: GoogleFonts.montserrat(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: DEFAULT_COLOR),
          ),
        ),
      ),
    );
  }
}
