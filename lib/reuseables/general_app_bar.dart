import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSize {
  const GeneralAppBar({
    Key? key,
    required this.input1,
    required this.onPress,
  }) : super(key: key);
  final String input1;
  final VoidCallback onPress;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
          child: Text(
            input1,
            style: const TextStyle(
                fontFamily: 'Lato', fontSize: 15.0, color: Color(0xff0D30D9)),
          ),
        ),
        
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff0D30D9),
            ),
            onPressed: onPress,
          ),
        ));
  }

  @override
  Widget get child => throw UnimplementedError();
}
