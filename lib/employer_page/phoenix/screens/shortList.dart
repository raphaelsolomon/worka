import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/Resusable.dart';

class ShortList extends StatefulWidget {
  const ShortList({Key? key}) : super(key: key);

  @override
  _ShortListState createState() => _ShortListState();
}

class _ShortListState extends State<ShortList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.menu),
                color: Color(0xff0D30D9),
                onPressed: () => Get.back(),
              ),
            ),
            Text('ShortList',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(null),
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Radio(
                  toggleable: true,
                  value: true,
                  groupValue: 'select_all',
                  onChanged: (status) {},
                ),
                Text('Select all',
                    style: GoogleFonts.montserrat(
                        fontSize: 11, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.start),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [...List.generate(10, (index) => shortList(context))],
          ))
        ],
      )),
    ));
  }
}
