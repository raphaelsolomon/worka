import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:http/http.dart' as http;
import 'package:worka/phoenix/model/Constant.dart';

import '../../../phoenix/dashboard_work/Success.dart';

class ReApplicantProfileEdit extends StatefulWidget {
  const ReApplicantProfileEdit({Key? key}) : super(key: key);

  @override
  _ReApplicantProfileEditState createState() => _ReApplicantProfileEditState();
}

class _ReApplicantProfileEditState extends State<ReApplicantProfileEdit> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final name = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    fname.text = '';
    lname.text = '';
    name.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Text('Edit Profile',
                  style:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Colors.black,
                  onPressed: null,
                ),
              )
            ]),
            const SizedBox(height: 5.0),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  imageView('${context.watch<Controller>().avatar}', context,
                      callBack: () async {
                    try {
                      final file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      context.read<Controller>().uploadCompanyImage(file!.path);
                    } on MissingPluginException {}
                  }),
                  const SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 25.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child:
                          getCardForm('First Name', 'First name', ctl: fname)),
                  SizedBox(height: 19.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: getCardForm('Last Name', 'Last name', ctl: lname)),
                  SizedBox(height: 19.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: getCardForm('Role Title', 'Role Title',
                          ctl: name)),
                  
                  SizedBox(height: 35.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Center(child: CircularProgressIndicator(color: DEFAULT_COLOR,))
                        : GeneralButtonContainer(
                            name: 'Save',
                            color: DEFAULT_COLOR,
                            textColor: Colors.white,
                            onPress: () => validate(),
                            paddingBottom: 3,
                            paddingLeft: 30,
                            paddingRight: 30,
                            paddingTop: 5,
                          ),
                  ),
                  SizedBox(height: 35.0),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  Padding buildPaddingDropdown(List<String> data, String data1, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: FormBuilderDropdown(
              name: 'skill',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                labelText: data1,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              // initialValue: 'Male',
              //hint: Text(data1),
              onChanged: (s) => callBack(s),
              items: data
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  getCardForm(label, hint, {ctl, read = false, formater}) {
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
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              readOnly: read,
              inputFormatters: formater,
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

  getCardDropForm(label, List<String> list, init, {callBack}) {
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
            child: FormBuilderDropdown(
              name: 'skill',
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none),
              ),
              hint: Text(
                init,
                style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45)
              ),
              onChanged: (s) => callBack(s),
              items: list
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          s,
                          style:GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  getCardRichForm(label, hint, {ctl}) {
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
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: null,
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

  void validate() {
    if (fname.text.trim() == "") {
      CustomSnack('Error', 'Please select a city.');
      return;
    }

    if (lname.text.trim() == "") {
      CustomSnack('Error', 'Please select a state.');
      return;
    }

    if (name.text.trim().isEmpty) {
      CustomSnack('Error', 'Please enter company name.');
      return;
    }

    executeData();
  }

  void executeData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res =
          await http.Client().post(Uri.parse('${ROOT}employerdetails/'), body: {
        'first_name': '${fname.text.trim()}',
        'last_name': '${lname.text.trim()}',
        'company_name': name.text.trim(),
      }, headers: {
        'Authorization': 'TOKEN ${context.read<Controller>().token}'
      });
      if (res.statusCode == 200) {
        Get.off(() => Success(
              'Profile updated successfully..',
              callBack: () => Get.back(),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'please check your internet connection');
    } on Exception {
      CustomSnack('Error', 'Could not submit details. Please try again');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
