import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:http/http.dart' as http;
import 'package:worka/phoenix/model/Constant.dart';

import '../../../phoenix/dashboard_work/Success.dart';

class EditCompany extends StatefulWidget {
  final CompModel compModel;
  const EditCompany(this.compModel, {Key? key}) : super(key: key);

  @override
  _EditCompanyState createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final cprofile = TextEditingController();
  final website = TextEditingController();
  final cAddress = TextEditingController();
  String position = '';
  String? address0 = "";
  String? address1 = "";
  String? address2 = "";
  String businessScale = '';
  String industries = '';
  bool isLoading = false;

  @override
  void initState() {
    fname.text = widget.compModel.firstName!;
    lname.text = widget.compModel.lastName!;
    name.text = widget.compModel.companyName!;
    email.text = widget.compModel.companyEmail!;
    industries = widget.compModel.industry!;
    address2 = widget.compModel.location!.split(',')[0];
    address1 = widget.compModel.location!.split(',')[1];
    address0 = widget.compModel.location!.split(',')[2];
    phone.text = widget.compModel.phone!;
    position = widget.compModel.position!;
    businessScale = widget.compModel.businessScale!;
    website.text = widget.compModel.companyWebsite!;
    cprofile.text = widget.compModel.companyProfile!;
    cAddress.text = widget.compModel.address!;
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
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black87)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child:
                          getCardForm('First Name', 'First name', ctl: fname)),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getCardForm('Last Name', 'Last name', ctl: lname)),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getCardForm('Company Name', 'Company Name',
                          ctl: name)),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: getCardForm('E-mail Address', 'E-mail Address',
                        ctl: email, read: true),
                  ),
                  SizedBox(height: 10.0),
                  buildCSC(),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getCardForm('Phone Number', 'Phone Number',
                          ctl: phone,
                          formater: [
                            MaskTextInputFormatter(mask: '+(###) ### ### ####')
                          ])),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: getCardDropForm('Industries', INDUSTRY_ITEMS,
                        '${widget.compModel.industry}',
                        callBack: (s) => {
                              setState(() {
                                industries = s;
                              })
                            }),
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getCardForm('Company Website', 'Company Website',
                          ctl: website)),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: getCardDropForm('Position', POSITIONITEM,
                        '${widget.compModel.position}',
                        callBack: (s) => {
                              setState(() {
                                position = s;
                              })
                            }),
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: getCardDropForm('Business Scale', BUSINESSSCALE,
                        '${widget.compModel.businessScale}',
                        callBack: (s) => {
                              setState(() {
                                businessScale = s;
                              })
                            }),
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getCardRichForm(
                          'Company Profile', 'Company Profile',
                          ctl: cprofile)),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child:
                          getCardRichForm('Address', 'Address', ctl: cAddress)),
                  SizedBox(height: 35.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Center(child: CircularProgressIndicator(color: DEFAULT_COLOR,))
                        : GeneralButtonContainer(
                            name: 'Update Bio',
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

  Widget buildCSC() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CSCPicker(
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border:
                Border.all(color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border:
                Border.all(color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),

        countrySearchPlaceholder: "Country",
        stateSearchPlaceholder: "State",
        citySearchPlaceholder: "City",

        ///labels for dropdown
        countryDropdownLabel: "${address0}",
        stateDropdownLabel: "${address1}",
        cityDropdownLabel: "${address2}",

        selectedItemStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),

        dropdownHeadingStyle: TextStyle(
            color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),

        dropdownItemStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        dropdownDialogRadius: 10.0,
        searchBarRadius: 10.0,
        onCountryChanged: (value) {
          setState(() {
            address0 = value;
          });
        },
        onStateChanged: (value) {
          setState(() {
            address1 = value;
          });
        },
        onCityChanged: (value) {
          setState(() {
            address2 = value;
          });
        },
      ));

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
            height: 100.0,
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
    if (address2 == "") {
      CustomSnack('Error', 'Please select a city.');
      return;
    }

    if (address1 == "") {
      CustomSnack('Error', 'Please select a state.');
      return;
    }
    if (address0 == "") {
      CustomSnack('Error', 'Please select a country.');
      return;
    }

    if (name.text.trim().isEmpty) {
      CustomSnack('Error', 'Please enter company name.');
      return;
    }

    if (phone.text.trim().isEmpty) {
      CustomSnack('Error', 'Please enter phone number.');
      return;
    }

    if (cprofile.text.trim().isEmpty) {
      CustomSnack('Error', 'Description about the company.');
      return;
    }

    if (cAddress.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter address.');
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
        'position': position.toLowerCase(),
        'company_profile': cprofile.text.trim(),
        'location': '${address2}, ${address1}, ${address0}',
        'phone': phone.text.trim(),
        'industry': industries.toLowerCase(),
        'business_scale': businessScale.toLowerCase(),
        'company_website': website.text.trim(),
        'address': cAddress.text.trim(),
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
