import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/Resusable.dart';

class AddOptions extends StatefulWidget {
  AddOptions({Key? key}) : super(key: key);

  @override
  State<AddOptions> createState() => _AddOptionsState();
}

class _AddOptionsState extends State<AddOptions> {
  final controller1 = TextEditingController();

  final controller2 = TextEditingController();

  final controller3 = TextEditingController();

  final controller4 = TextEditingController();

  final controller5 = TextEditingController();

  List<String> options = [];

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller5.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () => Get.back(),
              ),
            ),
            Text('Add Options',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(null),
                color: Color(0xff0D30D9),
                onPressed: () {},
              ),
            ),
          ]),
          SizedBox(height: 50.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Objective Options',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Color(0xff0D30D9)),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('A',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9))),
                      ),
                      SizedBox(height: 2.0),
                      CustomTextForm(controller1, 'Enter option A', 'Option A',
                          TextInputType.multiline),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('B',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9))),
                      ),
                      SizedBox(height: 2.0),
                      CustomTextForm(controller2, 'Enter option B', 'Option B',
                          TextInputType.multiline),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('C',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9))),
                      ),
                      SizedBox(height: 2.0),
                      CustomTextForm(controller3, 'Enter option C', 'Option C',
                          TextInputType.multiline),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('D',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9))),
                      ),
                      SizedBox(height: 2.0),
                      CustomTextForm(controller4, 'Enter option D', 'Option D',
                          TextInputType.multiline),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('Answer',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9))),
                      ),
                      SizedBox(height: 2.0),
                      CustomTextForm(
                          controller5,
                          'Answer must be a, b, c '
                              'or d',
                          'correct answer',
                          TextInputType.text,
                          format: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[a-d]')),
                          ]),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GeneralButtonContainer(
                      name: 'Save options',
                      color: Color(0xff0D30D9),
                      textColor: Colors.white,
                      onPress: () => validateController(),
                      paddingBottom: 3,
                      paddingLeft: 30,
                      paddingRight: 30,
                      paddingTop: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void validateController() {
    if (controller1.text.trim().isNotEmpty &&
        controller2.text.trim().isNotEmpty &&
        controller3.text.trim().isNotEmpty &&
        controller4.text.trim().isNotEmpty &&
        controller5.text.trim().isNotEmpty) {
      options.add(controller1.text.trim());
      options.add(controller2.text.trim());
      options.add(controller3.text.trim());
      options.add(controller4.text.trim());
      options.add(controller5.text.trim());
      if (options.length == 5) {
        controller1.clear();
        controller2.clear();
        controller3.clear();
        controller4.clear();
        controller5.clear();
        context.read<EmpController>().setOptionObj(options);
      }
    } else {
      CustomSnack('Error', 'All Fields are required..');
    }
  }
}
