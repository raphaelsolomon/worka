import 'package:flutter/material.dart';

class Working extends StatefulWidget {
  const Working({Key? key}) : super(key: key);

  @override
  _WorkingState createState() => _WorkingState();
}

class _WorkingState extends State<Working> {
  List list = [];
  List info = [];
  readData() async {
    // await Default.of(context).loadString('')
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
