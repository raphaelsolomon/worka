import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/controllers/loading_controller.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/model/Constant.dart';
import '../../Resusable.dart';

class AddExperience extends StatefulWidget {
  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  final title = TextEditingController();

  final company = TextEditingController();

  final desc = TextEditingController();

  final startDate = TextEditingController();

  final stopDate = TextEditingController();

  var stringStart =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  var stringStop =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: DEFAULT_COLOR,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text('Add Experience',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: DEFAULT_COLOR),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: IconButton(
                    icon: Icon(null),
                    color: Colors.black,
                    onPressed: null,
                  ),
                )
              ]),
              const SizedBox(height: 8.0),
              imageView('${context.watch<Controller>().avatar}'),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Work Experience',
                    style: GoogleFonts.lato(
                        fontSize: 14.0,
                        color: Colors.blue,
                        decoration: TextDecoration.none)),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomTextForm(
                  title, 'Software Engineer', 'job title', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              CustomTextForm(
                  company, 'Aptech Dev Center', 'company', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              CustomRichTextForm(
                  desc, null, 'Work Description', TextInputType.text, 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: context.watch<Controller>().isCurrently,
                        onChanged: (b) {
                          context.read<Controller>().setCurrently(b);
                        }),
                    Text(
                      'Current Working',
                      style: GoogleFonts.montserrat(
                          fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Start Date',
                        onChanged: (val) => setState(() {
                          stringStart = val;
                        }),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'End Date',
                        onChanged: (val) => setState(() {
                          stringStop = val;
                        }),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ChangeNotifierProvider(
                      create: (context) => LoadingController(),
                      builder: (ctx, w) =>
                          ctx.watch<LoadingController>().isAddExperience
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GeneralButtonContainer(
                                  name: 'Add Experience',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () {
                                    ctx.read<LoadingController>().addExperience(
                                        title.text.trim(),
                                        company.text.trim(),
                                        stringStart,
                                        stringStop,
                                        desc.text.trim(),
                                        context);
                                  },
                                  paddingBottom: 3,
                                  paddingLeft: 30,
                                  paddingRight: 30,
                                  paddingTop: 5,
                                ),
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
