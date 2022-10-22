import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import '../phoenix/GeneralButtonContainer.dart';
import '../phoenix/Resusable.dart';
import '../phoenix/model/Constant.dart';
import 'package:http/http.dart' as http;

class Help_Center extends StatefulWidget {
  const Help_Center({Key? key}) : super(key: key);

  @override
  State<Help_Center> createState() => _Help_CenterState();
}

class _Help_CenterState extends State<Help_Center> {
  bool isLoading = false;
  int counter = 0;
  final fullname = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final title = TextEditingController();
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Text('Help Center',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: Color(0xff0D30D9)),
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
            const SizedBox(height: 5.0),
            Expanded(child: counter == 0 ? _step1(context) : _step2(context)),
          ],
        ),
      ),
    );
  }

  Widget _step1(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/take.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Our offices:',
                style:
                    GoogleFonts.montserrat(fontSize: 17.0, color: Colors.black),
              ),
              const SizedBox(height: 5.0),
              Text(
                'United States',
                style:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              Text(
                'US Address-1821 Sulis Street Philadelphia PA 19142',
                style:
                    GoogleFonts.montserrat(fontSize: 14.0, color: Colors.black),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Phone Number:',
                style:
                    GoogleFonts.montserrat(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: '+12673399844',
                  );
                  await launchUrlString(launchUri.toString());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: DEFAULT_COLOR,
                      size: 17.0,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      '+12673399844',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: DEFAULT_COLOR),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Text(
                'Nigeria',
                style:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              Text(
                '8 Fadare street Ogba, Lagos Nigeria',
                style:
                    GoogleFonts.montserrat(fontSize: 14.0, color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    'phone number:',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(width: 5.0),
                  Icon(
                    Icons.call,
                    color: DEFAULT_COLOR,
                    size: 17.0,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '+2349049985244',
                        );
                        await launch(launchUri.toString());
                      },
                      child: Text(
                        '+2349049985244',
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: DEFAULT_COLOR),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '+2348167962187',
                        );
                        await launch(launchUri.toString());
                      },
                      child: Text(
                        '+2348167962187',
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: DEFAULT_COLOR),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '+2348113553190',
                        );
                        await launchUrlString(launchUri.toString());
                      },
                      child: Text(
                        '+2348113553190',
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: DEFAULT_COLOR),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '+2348066475417',
                        );
                        await launch(launchUri.toString());
                      },
                      child: Text(
                        '+2348066475417',
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: DEFAULT_COLOR),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '+2348030718703',
                        );
                        await launch(launchUri.toString());
                      },
                      child: Text(
                        '+2348030718703',
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: DEFAULT_COLOR),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Text(
                    'contact email:',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(width: 5.0),
                  Icon(
                    Icons.mail,
                    size: 17.0,
                    color: DEFAULT_COLOR,
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  _launchEmail('contact@workanetworks.com');
                },
                child: Text(
                  'contact@workanetworks.com',
                  style: GoogleFonts.montserrat(
                      fontSize: 14.0, color: DEFAULT_COLOR),
                ),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  _launchEmail('customercare@workanetworks.com');
                },
                child: Text(
                  'customercare@workanetworks.com',
                  style: GoogleFonts.montserrat(
                      fontSize: 14.0, color: DEFAULT_COLOR),
                ),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  _launchEmail('support@workanetworks.com');
                },
                child: Text(
                  'support@workanetworks.com',
                  style: GoogleFonts.montserrat(
                      fontSize: 14.0, color: DEFAULT_COLOR),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GeneralButtonContainer(
                  name: 'Message Directly',
                  color: DEFAULT_COLOR,
                  textColor: Colors.white,
                  onPress: () {
                    setState(() {
                      counter = 1;
                    });
                  },
                  paddingBottom: 20,
                  paddingLeft: 30,
                  paddingRight: 30,
                  paddingTop: 30,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _step2(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/take.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Text('', style: GoogleFonts.montserrat(fontSize: 15.0, color:
            Colors.black),),
            const SizedBox(height: 20.0),
            CustomAuthForm('Full Name', 'Full Name', TextInputType.text,
                ctl: fullname, right: 15.0, left: 15.0),
            CustomAuthForm(
                'Email Address', 'Email Address', TextInputType.emailAddress,
                ctl: email, right: 15.0, left: 15.0),
            CustomAuthForm('Phone number', 'Phone Number',
                TextInputType.numberWithOptions(decimal: false),
                ctl: number, right: 15.0, left: 15.0),
            CustomAuthForm('Title', 'title', TextInputType.text,
                ctl: title, right: 15.0, left: 15.0),
            CustomRichTextForm(message, 'Message Body', 'Message Body',
                TextInputType.multiline, 20,
                horizontal: 15.0, onChange: (s) => null),
            Container(
              width: MediaQuery.of(context).size.width,
              child: isLoading ? Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CircularProgressIndicator(),
              ),) :
                GeneralButtonContainer(
                name: 'Send',
                color: DEFAULT_COLOR,
                textColor: Colors.white,
                onPress: () {
                  execute();
                },
                paddingBottom: 20,
                paddingLeft: 30,
                paddingRight: 30,
                paddingTop: 30,
              ),
            ),
          ],
        ),
      );

  _launchEmail(email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  execute() async {
    if (fullname.text.trim().isEmpty) {
      CustomSnack('Error', 'Fullname must not be empty');
      return;
    }

    if (email.text.trim().isEmpty) {
      CustomSnack('Error', 'email must not be empty');
      return;
    }

    if (number.text.trim().isEmpty) {
      CustomSnack('Error', 'Number must not be empty');
      return;
    }

    if (title.text.trim().isEmpty) {
      CustomSnack('Error', 'Message Title must not be empty');
      return;
    }

    if (message.text.trim().isEmpty) {
      CustomSnack('Error', 'Message Body must not be empty');
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      final res =
          await http.Client().post(Uri.parse('${ROOT}support_message/'), body: {
        'email': email.text.trim(),
        'phone': number.text.trim(),
        'fullname': fullname.text.trim(),
        'title': title.text.trim(),
        'message': message.text.trim()
      });
      if (res.statusCode == 200) {
        print('good');
        Get.off(() => Success('Message sent successfully...', callBack: () {
              Get.back();
            }));
      }
    } on SocketException {
      CustomSnack('Error', 'Please check internet connection..');
    } on Exception {
      CustomSnack('Error', 'Unable to submit form..');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
