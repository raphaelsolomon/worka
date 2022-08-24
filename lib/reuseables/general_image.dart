import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GeneralImage extends StatelessWidget {
  const GeneralImage({Key? key, required this.image1, required this.image2, required this.image3,
    required this.onPress1, required this.onPress2, required this.onPress3}) : super(key: key);
  final String image1;
  final String image2;
  final String image3;
  final VoidCallback onPress1;
  final VoidCallback onPress2;
  final VoidCallback onPress3;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPress1,
            child: Image.asset(
              image1,
              height: 20.0,
              width: 20.0,
            ),
          ),
          GestureDetector(
            onTap: onPress2,
            child: Image.asset(
              image2,
              height: 20.0,
              width: 20.0,
            ),
          ),
          GestureDetector(
            onTap: onPress3,
            child: Image.asset(
              image3,
              height: 40.0,
              width: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
