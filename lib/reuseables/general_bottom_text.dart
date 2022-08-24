import 'package:flutter/material.dart';


class GeneralBottomText extends StatelessWidget {
  const GeneralBottomText({Key? key, required this.input1, required this.input2, required this.onPress}) : super(key: key);
  final String input1;
  final String input2;
  final VoidCallback  onPress;

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(input1),
        TextButton(
          onPressed: onPress,
          child:  Text(
            input2,
            style: const TextStyle(color: Color(0xff0D30D9)),
          ),
        ),
      ],
    );
  }
}
