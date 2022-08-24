import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:file_picker/file_picker.dart';
import '../Controller.dart';
import '../CustomScreens.dart';
import '../GeneralButtonContainer.dart';
import '../Resusable.dart';

class PersonalDetails extends StatefulWidget {
  final Map setMap;
  PersonalDetails(this.setMap, {Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final othername = TextEditingController();
  final about = TextEditingController();
  final phone = TextEditingController();
  String? address0 = 'Country';
  String? address1 = 'State';
  String? address2 = 'City';

  @override
  void initState() {
    firstname.text = widget.setMap['firstname'];
    lastname.text = widget.setMap['lastname'];
    othername.text = widget.setMap['othername'];
    address0 = widget.setMap['countryValue'];
    address1 = widget.setMap['stateValue'];
    phone.text = widget.setMap['phone'];
    address2 = widget.setMap['cityValue'];
    about.text = widget.setMap['about'];
    super.initState();
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    othername.dispose();
    about.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final execution = context.read<Controller>();
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: DEFAULT_COLOR,
                onPressed: () => Get.back(),
              ),
            ),
            Text('Edit Profile',
                style:
                    GoogleFonts.montserrat(fontSize: 18, color: DEFAULT_COLOR),
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
          SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  imageView('${context.watch<Controller>().avatar}'),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Flexible(
                        child: CustomDatePicker(
                            execution.cv == ''
                                ? 'Add Resume'
                                : execution.cv.split('/').last,
                            cB: () {},
                            border: Border.all(
                                color: execution.cv == ''
                                    ? Colors.grey.shade100
                                    : Color(0xFF1B6DF9).withOpacity(.2))),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null) {
                              execution.uploadCV(
                                  result.files.single.path!, context);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: context.watch<Controller>().cvLoading
                              ? SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: DEFAULT_COLOR,
                                  ))
                              : Icon(Icons.add_circle, color: DEFAULT_COLOR)),
                      const SizedBox(width: 30),
                    ],
                  ),
                  SizedBox(height: 9.0),
                  CustomTextForm(
                      firstname,
                      '${context.watch<Controller>().profileModel!.firstName}',
                      'First name',
                      TextInputType.text,
                      read: false),
                  SizedBox(height: 7.0),
                  CustomTextForm(
                      lastname,
                      '${context.watch<Controller>().profileModel!.lastName}',
                      'Last name',
                      TextInputType.text,
                      read: false),
                  SizedBox(height: 7.0),
                  CustomTextForm(
                      othername,
                      '${context.watch<Controller>().profileModel!.otherName}',
                      'Other names',
                      TextInputType.text,
                      read: false),
                  SizedBox(height: 7.0),
                  CustomTextForm(
                      phone,
                      '${context.watch<Controller>().profileModel!.phone}',
                      'Phone Number',
                      TextInputType.phone,
                      read: false,
                      format: [
                        MaskTextInputFormatter(mask: '+(###) ### ### ####')
                      ]),
                  SizedBox(height: 9.0),
                  buildCSC(),
                  SizedBox(height: 10.0),
                  CustomRichTextForm(
                      about,
                      '${context.watch<Controller>().profileModel!.about}',
                      'About',
                      TextInputType.multiline,
                      null),
                  SizedBox(height: 35.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: context.watch<Controller>().isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GeneralButtonContainer(
                            name: 'Update',
                            color: DEFAULT_COLOR,
                            textColor: Colors.white,
                            onPress: () => context
                                .read<Controller>()
                                .updateProfile(
                                    firstname.text,
                                    lastname.text,
                                    othername.text,
                                    '${address2}, ${address1}, ${address0}',
                                    about.text,
                                    phone.text),
                            paddingBottom: 3,
                            paddingLeft: 30,
                            paddingRight: 30,
                            paddingTop: 5,
                          ),
                  ),
                  SizedBox(height: 35.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildCSC() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CSCPicker(
        currentCountry: '${address0}',
        currentState: '${address1}',
        currentCity: '${address2}',
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
}
