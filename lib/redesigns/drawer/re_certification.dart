import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
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
                        Icons.menu,
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
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
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
                        )),
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

  getCardDateForm(label, {datetext}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    dateLabelText: 'Start Date',
                    onChanged: (val) => datetext = val,
                  ),
                ),
                const SizedBox(width: 10.0),
                Icon(
                  Icons.timelapse,
                  color: Colors.black26,
                  size: 18.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
    return Column(
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
          height: MediaQuery.of(context).size.height / 2.4,
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
