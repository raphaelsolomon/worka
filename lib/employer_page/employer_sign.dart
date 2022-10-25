import 'package:csc_picker/csc_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:worka/employer_page/review_plan.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/reuseables/general_button_container.dart';

import '../controllers/constants.dart';
import '../phoenix/dashboard_work/preview.dart';

class EmployerSignUp extends StatefulWidget {
  const EmployerSignUp({Key? key}) : super(key: key);

  @override
  _EmployerSignUpState createState() => _EmployerSignUpState();
}

class _EmployerSignUpState extends State<EmployerSignUp> {
  bool hidePassword1 = true;
  final firstnameController = TextEditingController();
  final lastNameController = TextEditingController();
  final industryController = TextEditingController();
  final companyNameController = TextEditingController();
  final myControllerWebsite = TextEditingController();
  final companyController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final passwordController = TextEditingController();
  final c_passwordController = TextEditingController();
  //=================================
  String? contact = '';
  String? address2 = 'City';
  String? address0 = 'Country';
  String? address1 = 'State';
  bool phoneValidate = false;
  bool isAccepted = false;
  //======================================
  String industries = '';
  String businessScale = '';
  String position = '';
  bool isLoading = false;
  String plan = '';

  bool isPassVisible = false;
  bool isCPassVisible = false;

  int pageCounter = 0;

  @override
  void dispose() {
    firstnameController.dispose();
    companyNameController.dispose();
    lastNameController.dispose();
    industryController.dispose();
    myControllerWebsite.dispose();
    companyController.dispose();
    contactController.dispose();
    emailController.dispose();
    websiteController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: DEFAULT_COLOR,
                  onPressed: () => Get.back(),
                ),
              ),
              Text('Register',
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Colors.transparent,
                  onPressed: null,
                ),
              ),
            ]),
            Image.asset(
              'assets/black.png',
              fit: BoxFit.contain,
              height: 100,
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Sign up to get more feature and experience from '
                'workanetwork',
                style: GoogleFonts.lato(
                    height: 1.5, fontSize: 15.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        pageCounter = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: const Color(0xffC7C7C7).withOpacity(.127),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: pageCounter == 0
                                  ? const Color(0xff0D30D9)
                                  : Colors.transparent)),
                      child: Center(
                          child: Text(
                        'Personal Infomation',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.0, fontWeight: FontWeight.w500),
                      )),
                    ),
                  )),
                  const SizedBox(width: 10.0),
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        pageCounter = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: const Color(0xffC7C7C7).withOpacity(.17),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: pageCounter == 1
                                  ? const Color(0xff0D30D9)
                                  : Colors.transparent)),
                      child: Center(
                          child: Text(
                        'Contact Information',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.0, fontWeight: FontWeight.w500),
                      )),
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
              child: pageCounter == 0 ? buildPersonal() : buildContact(),
            ),
          ],
        ),
      ),
    );
  }

  buildPersonal() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: getCardForm('First name', 'First name',
                  ctl: firstnameController),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: getCardForm('Last name', 'Last name',
                  ctl: lastNameController),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: getCardForm('Company Name', 'Company Name',
                  ctl: companyNameController),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: inputDropDown(INDUSTRY_ITEMS, callBack: (s) {
                industries = s;
              }, text: 'Industry', hint: 'Select industry'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: inputDropDown(BUSINESS_SCALE_ITEM, callBack: (s) {
                businessScale = s;
              }, text: 'Business Scale', hint: 'Select business scale'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: inputDropDown(POSITIONITEM, callBack: (s) {
                position = s;
              }, text: 'Position', hint: 'Select position'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            GeneralButtonContainer(
                paddingWidth: MediaQuery.of(context).size.width,
                paddingHeight: 50,
                name: 'Proceed',
                onPress: () {
                  setState(() {
                    pageCounter = 1;
                  });
                },
                paddingLeft: 25,
                paddingTop: 20,
                paddingRight: 25,
                radius: 10,
                paddingBottom: 20),
          ],
        ),
      ),
    );
  }

  buildContact() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: getCardForm('Company Email', 'Company Email',
                  ctl: companyController),
            ),
            const SizedBox(
              height: 12.0,
            ),
            getCardFormPhone('Mobile Number', 'Mobile Number'),
            const SizedBox(
              height: 12.0,
            ),
            getCardForm('Website', 'Website', ctl: myControllerWebsite),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Country, State and City',
                  style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                )),
            const SizedBox(height: 10.0),
            buildCSC(),
            const SizedBox(
              height: 12.0,
            ),
            getCardForm('Email', 'Email', ctl: emailController),
            const SizedBox(
              height: 12.0,
            ),
            getCardFormPassword('Password', 'Password', isPassVisible,
                ctl: passwordController),
            const SizedBox(
              height: 12.0,
            ),
            getCardFormPassword(
                'Confirm Password', 'Confirm Password', isCPassVisible,
                ctl: c_passwordController),
            const SizedBox(
              height: 7.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: GeneralButtonContainer(
                        paddingHeight: 50,
                        paddingWidth: MediaQuery.of(context).size.width,
                        name: 'Back',
                        onPress: () {
                          setState(() {
                            pageCounter = 0;
                          });
                        },
                        paddingLeft: 5,
                        paddingTop: 15,
                        paddingRight: 5,
                        radius: 10,
                        paddingBottom: 20),
                  ),
                  Flexible(
                    child: GeneralButtonContainer(
                        paddingHeight: 50,
                        paddingWidth: MediaQuery.of(context).size.width,
                        name: 'Proceed',
                        onPress: () => registrationUser(),
                        paddingLeft: 5,
                        paddingTop: 15,
                        paddingRight: 5,
                        radius: 10,
                        paddingBottom: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  registrationUser() async {
    if (address2 == "City") {
      CustomSnack('Error', 'Select City');
      return;
    }

    if (!isAccepted) {
      CustomSnack('Error', 'Accept the terms of services');
      return;
    }

    if (address0 == "Country") {
      CustomSnack('Error', 'Select Country');
      return;
    }

    if (address1 == 'State') {
      CustomSnack('Error', 'Select State');
      return;
    }

    if (contactController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter phone number');
      return;
    }

    if (firstnameController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter first name');
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter last name');
      return;
    }

    if (companyController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter Company E-mail');
      return;
    }

    if (businessScale == '') {
      CustomSnack('Error', 'Select Business scale');
      return;
    }

    if (position == '') {
      CustomSnack('Error', 'Select position');
      return;
    }

    if (industries == '') {
      CustomSnack('Error', 'Select industry');
      return;
    }

    if (businessScale == '') {
      CustomSnack('Error', 'Select Business scale');
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter password');
      return;
    }

    if (c_passwordController.text.trim().isEmpty) {
      CustomSnack('Error', 'Enter Confirm password');
      return;
    }

    if (c_passwordController.text != passwordController.text) {
      CustomSnack('Error', 'Password does not match');
      return;
    }

    Map mapData = {
      'phone': '$contact',
      'first_name': firstnameController.text,
      'last_name': lastNameController.text,
      'company_name': companyNameController.text,
      'company_email': companyController.text,
      'company_website': myControllerWebsite.text,
      'business_scale': businessScale.toLowerCase(),
      'position': position.toLowerCase(),
      'location': '${address2}, ${address1}, ${address0}',
      'industry': industries.toLowerCase().toString(),
      'account_type': 'employer',
      'email': emailController.text,
      'password': passwordController.text,
      're_password': c_passwordController.text,
    };
    Get.to(() => ReviewPlanPrice(mapData));
  }

  Widget buildCSC() => Container(
      //color: DEFAULT_COLOR.withOpacity(.05),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CSCPicker(
        currentCountry: 'United States',
        currentState: 'California',
        currentCity: 'Acton',
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: DEFAULT_COLOR.withOpacity(.05),
            border:
                Border.all(color: Color(0xFF1B6DF9).withOpacity(.2), width: 1)),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: DEFAULT_COLOR.withOpacity(.05),
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

  getCardFormPhone(label, hint, {ctl}) {
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
              color: DEFAULT_COLOR.withOpacity(.08),
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
