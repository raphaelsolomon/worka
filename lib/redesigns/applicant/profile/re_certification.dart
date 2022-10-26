import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class Redesigncertification extends StatefulWidget {
  const Redesigncertification({super.key});

  @override
  State<Redesigncertification> createState() => _RedesigncertificationState();
}

class _RedesigncertificationState extends State<Redesigncertification> {
  final title = TextEditingController();
  final issuer = TextEditingController();
  var stringStart = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  final ceritificateID = TextEditingController();
  final ceritificateURL = TextEditingController();

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Certification',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  getCardForm('Title', 'Title', ctl: title),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardForm('Issuer', 'Issuer', ctl: issuer),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardDateForm('Issuer Date', datetext: stringStart),
                  const SizedBox(
                    height: 5.0,
                  ), 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          onChanged: (b) {
                            setState(() {
                              isChecked = !b!;
                            });
                          },
                          value: isChecked,
                          activeColor: DEFAULT_COLOR,
                        ),
                        Text(
                          'This will not expire',
                          style: GoogleFonts.lato(
                              fontSize: 12.0, color: Colors.black38),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardForm('Certificate ID', 'Certificate ID',
                      ctl: ceritificateID),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardForm('Certificate URL', 'Certificate URL',
                      ctl: ceritificateURL),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DEFAULT_COLOR),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: GoogleFonts.lato(
                                fontSize: 15.0, color: Colors.white),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget inputDropDown(List<String> list,
      {text = 'Select certificate', hint = 'Certificate', callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: FormBuilderDropdown(
              name: 'dropDown',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              // initialValue: 'Male',
              onChanged: (s) => callBack(s),
              hint: Text('$hint',
                  style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
              items: list
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          '$s',
                          style: GoogleFonts.lato(
                              fontSize: 15.0, color: Colors.black54),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  getCardDateForm(label, {datetext}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: Row(
              children: [
                Flexible(
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)
                    ),
                    onChanged: (val) => datetext = val,
                  ),
                ),
                const SizedBox(width: 10.0),
                Icon(
                  Icons.timelapse,
                  color: Colors.black26,
                  size: 18.0,
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  Widget inputWidgetRich({hint = 'Type here', ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brief Description',
            style: GoogleFonts.lato(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: MediaQuery.of(context).size.height / 6.5,
            decoration: BoxDecoration(
              color: DEFAULT_COLOR.withOpacity(.05),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              controller: ctl,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.black54),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                  hintText: '$hint',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }
}
