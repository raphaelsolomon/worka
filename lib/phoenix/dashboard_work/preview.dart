import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  final Widget preview;
  Screens(this.preview);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: preview),
    );
  }
}
