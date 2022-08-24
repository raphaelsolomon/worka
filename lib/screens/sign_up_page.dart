import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:worka/controllers/registration_controller.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/reuseables/general_app_bar.dart';
import 'package:worka/reuseables/general_button_container.dart';
import 'package:worka/reuseables/general_contact_textfield.dart';
import 'package:worka/reuseables/general_password_textfield.dart';
import 'package:worka/reuseables/general_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  RegistrationController registrationController = RegistrationController();
  bool hidePassword1 = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final countryValue = "";
  final stateValue = "";
  final cityValue = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              input1: 'Sign up Information', onPress: () => Get.back()),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(33, 50, 33, 0),
                child: TabBar(
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      fontFamily: 'Lato'),
                  labelColor: const Color(0xff0D30D9),
                  unselectedLabelColor: const Color(0xffC7C7C7),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff0D30D9))),
                  tabs: const [
                    Tab(
                      text: 'Personal Information',
                    ),
                    Tab(text: 'Contact Information')
                  ],
                ),
              ),
              SizedBox(
                height: 1000,
                child: TabBarView(
                  children: [
                    buildPersonal(
                      firstNameController,
                      middleNameController,
                      surNameController,
                    ),
                    
                    buildContact(
                        emailController, contactController, passwordController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPersonal(
      TextEditingController myControllerFirst,
      TextEditingController myControllerMiddle,
      TextEditingController myControllerSur) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GeneralTextField(
              input1: 'First name',
              myController: myControllerFirst,
              isEmail: false,
            ),
            GeneralTextField(
              input1: 'Middle name',
              myController: myControllerMiddle,
              isEmail: false,
            ),
            GeneralTextField(
              input1: 'Surname',
              myController: myControllerSur,
              isEmail: false,
            ),
            // GeneralButtonContainer(
            //     paddingTop: 25,
            //     paddingBottom: 100,
            //     paddingRight: 55,
            //     paddingLeft: 55,
            //     name: '',
            //     onPress: () => {
            //           buildContact,
            //         }),
          ],
        ),
      ),
    );
  }

  buildContact(
    TextEditingController myControllerEmail,
    TextEditingController myControllerContact,
    TextEditingController myControllerPassword,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GeneralTextField(
              myController: myControllerEmail,
              input1: 'Email',
              isEmail: true,
            ),
            GeneralContactTextField(
              input: 'Contact Info',
              controller: myControllerContact,
            ),
            GeneralPasswordTextField(
                passwordController: myControllerPassword,
                input1: 'Password',
                input2: '**********'),
            GeneralButtonContainer(
                paddingHeight: 50,
                paddingWidth: 200,
                paddingTop: 25,
                paddingBottom: 100,
                paddingRight: 55,
                paddingLeft: 55,
                radius: 10,
                name: 'Submit',
                onPress: () {
                  uploadData();
                }),
          ],
        ),
      ),
    );
  }

  void uploadData() async {
    final url = Uri.parse('${ROOT}addemployee/');
    var request = http.MultipartRequest('POST', url);
    request.fields['phone'] = contactController.text;
    request.fields['first_name'] = surNameController.text;
    request.fields['last_name'] = firstNameController.text;
    request.fields['other_name'] = middleNameController.text;
    request.fields['account_type'] = 'employee';
    request.fields['location'] = '${countryValue}, ${stateValue}, ${cityValue}';
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['re_password'] = passwordController.text;
    var response = await request.send();
    if (response.statusCode == 201 || response.statusCode == 200) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Registration Successful!",
      );
    } else if (response.statusCode == 201 || response.statusCode == 200) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Registration Not successful!",
      );
    }
  }
}
