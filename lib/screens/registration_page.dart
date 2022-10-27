import 'dart:async';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:worka/models/customCountry.dart';
import 'package:worka/phoenix/Helper.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/reuseables/general_container.dart';
import 'package:worka/screens/login_screen.dart';

import '../phoenix/CustomScreens.dart';
import '../phoenix/dashboard_work/preview.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final surNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String? address0 = 'Country';
  String? address1 = 'State';
  bool isAccepted = false;
  String? address2 = 'City';
  String? contact = '';
  bool phoneValidate = false;
  DateTime dateOfBirth = DateTime(1898);

  Future registrationUser() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('${ROOT}addemployee/');
    Map mapData = {
      'phone': '$contact',
      'first_name': surNameController.text.trim(),
      'last_name': firstNameController.text.trim(),
      'other_name': middleNameController.text.trim(),
      'date_of_birth': DateFormat('yyyy-MM-dd').format(dateOfBirth),
      'location': '${address2}, ${address1}, ${address0}',
      'gender': '${context.read<Helper>().gender}'.toLowerCase(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      're_password': passwordController.text.trim(),
    };
    try {
      final response = await http.Client().post(url, body: mapData);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.success,
            text:
                "Complete your registration by verifying the mail sent to this e-mail address",
            onConfirmBtnTap: () {
              Get.off(() => const LoginScreen());
            });
      } else {
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: response.body.toString(),
          onConfirmBtnTap: () {
            Get.back();
          },
        );
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Error while submitting information..');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String termsPath = '';

  @override
  void initState() {
    fromAsset('assets/Terms.pdf', 'Terms.pdf').then((value) {
      setState(() {
        termsPath = value.path;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xff0D30D9),
                    onPressed: () => Get.back(),
                  ),
                ),
                Text('Sign Up Information',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black54),
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
              SizedBox(height: 20.0),
              GeneralContainer(
                  name: 'Personal Information',
                  onPress: () {},
                  paddingLeft: 33,
                  paddingTop: 0,
                  paddingRight: 33,
                  paddingBottom: 0,
                  width: 100,
                  bcolor: const Color(0xffFFFFFF),
                  stroke: 0,
                  height: 50,
                  size: 12),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    getCardForm('Firstname', 'Firstname',
                        ctl: firstNameController),
                    const SizedBox(
                      height: 15,
                    ),
                    getCardForm('Middle name', 'Middle name',
                        ctl: middleNameController),
                    const SizedBox(
                      height: 15,
                    ),
                    getCardForm('Surname', 'Surname', ctl: surNameController),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Date of Birth',
                          style: GoogleFonts.lato(
                              fontSize: 15.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 0.0),
                    CustomDatePicker(
                        dateOfBirth == DateTime.now()
                            ? 'Date Of Birth'
                            : DateFormat('dd EEEE, MMM, yyyy')
                                .format(dateOfBirth), cB: () {
                      selectDateOfBirth(context);
                    },
                        border: Border.all(
                            color: Color(0xFF1B6DF9).withOpacity(.2))),
                    const SizedBox(
                      height: 15,
                    ),
                    getCardForm('Email', 'Email', ctl: emailController),
                    GeneralContainer(
                        name: 'Contact Information',
                        onPress: () {},
                        paddingLeft: 33,
                        paddingTop: 20,
                        paddingRight: 33,
                        paddingBottom: 20,
                        width: 200,
                        bcolor: const Color(0xffFFFFFF),
                        stroke: 0,
                        height: 50,
                        size: 12),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Country, State and City',
                          style: GoogleFonts.lato(
                              fontSize: 15.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 10.0),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: buildCSC()),

                    const SizedBox(
                      height: 15,
                    ),
                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Gender',
                          style: GoogleFonts.lato(
                              fontSize: 15.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Radio<bool>(
                                  value:
                                      context.watch<Helper>().gender == 'Male'
                                          ? true
                                          : false,
                                  toggleable: true,
                                  activeColor: DEFAULT_COLOR,
                                  groupValue: true,
                                  onChanged: (b) {
                                    context.read<Helper>().setGender('Male');
                                  }),
                              Text('Male',
                                  style: GoogleFonts.lato(fontSize: 12))
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Row(
                            children: [
                              Radio<bool>(
                                  value:
                                      context.watch<Helper>().gender != 'Male'
                                          ? true
                                          : false,
                                  toggleable: true,
                                  activeColor: DEFAULT_COLOR,
                                  groupValue: true,
                                  onChanged: (b) {
                                    context.read<Helper>().setGender('Female');
                                  }),
                              Text('Female',
                                  style: GoogleFonts.lato(fontSize: 12))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // CustomAuthForm(
                    //     'Contact Info', 'Contact Info', TextInputType.text,
                    //     ctl: contactController),
                   getCardFormPhone('Mobile Number', 'Mobile Number'),
                    const SizedBox(
                      height: 15,
                    ),
                    getCardFormPassword(
                      'Confirm Password',
                      'Confirm Password',
                      false,
                      ctl: passwordController,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getCardFormPassword(
                      'Confirm Password',
                      'Confirm Password',
                      false,
                      ctl: confirmPasswordController,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: isAccepted,
                              onChanged: (b) {
                                setState(() {
                                  isAccepted = b!;
                                });
                              }),
                          Text(
                            'I have read and accept the',
                            style: GoogleFonts.montserrat(
                                fontSize: 13.0, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => Screens(termOfUse(context)));
                            },
                            child: Text(
                              ' Terms of Services',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.0, color: DEFAULT_COLOR),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (firstNameController.text.isEmpty ||
                            middleNameController.text.isEmpty ||
                            surNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            address2 == 'City' ||
                            address0 == 'Country' ||
                            address1 == 'State' ||
                            confirmPasswordController.text.isEmpty) {
                          Get.snackbar(
                              'Error', 'Pls Enter all required Fields');
                          return;
                        }

                        if (!isAccepted) {
                          Get.snackbar(
                              'Error',
                              'Accept the terms of use of this '
                                  'platform');
                          return;
                        }

                        if (!phoneValidate) {
                          Get.snackbar(
                              'Error', 'Pls Enter a valid phone number');
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        registrationUser();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 25, 30, 100),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff0D30D9)),
                          child: isLoading
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Please Wait...',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                )
                              : Text(
                                  'Submit',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCSC() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CSCPicker(
        currentCountry: 'United States',
        currentState: 'California',
        currentCity: 'Acton',
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: DEFAULT_COLOR.withOpacity(.05),
            border: Border.all(color: Colors.transparent, width: 1)),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border.all(color: Colors.transparent, width: 1)),

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

  selectDateOfBirth(BuildContext c) async {
    var selectedDate = await showDatePicker(
        context: c,
        initialDate: dateOfBirth,
        firstDate: dateOfBirth,
        lastDate: DateTime.now());
    if (selectedDate != null && selectedDate != dateOfBirth) {
      setState(() {
        dateOfBirth = selectedDate;
      });
    }
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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

  getCardFormPhone(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
              child: InternationalPhoneNumberInput(
                  selectorConfig: SelectorConfig(showFlags: true),
                  onInputValidated: (b) {
                    phoneValidate = b;
                  },
                  textFieldController: contactController,
                  inputDecoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'phone number',
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14.0, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onInputChanged: (phone) {
                    contact = phone.phoneNumber;
                  }))
        ],
      ),
    );
  }

  Widget inputDropDown(List<String> list,
      {text = 'Benefits', hint = 'Insurance', callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              color: DEFAULT_COLOR.withOpacity(.03),
              borderRadius: BorderRadius.circular(10.0),
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
                  style:
                      GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
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

  getCardFormPassword(label, hint, hidePassword, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      hidePassword = !hidePassword;
                    }),
                    color: Colors.black,
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
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
}
