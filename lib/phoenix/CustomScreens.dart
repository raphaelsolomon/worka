// ignore_for_file: avoid_print, prefer_const_constructors, sized_box_for_whitespace, unused_element, duplicate_ignore

import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/employer_settings.dart';
import 'package:worka/employer_page/phoenix/screens/EmpInterviews.dart';
import 'package:worka/employer_page/phoenix/screens/EmpObjQuestions.dart';
import 'package:worka/employer_page/phoenix/screens/companyProfile.dart';
import 'package:worka/employer_page/phoenix/screens/postedJobs.dart';
import 'package:worka/employer_page/phoenix/screens/theoryQuestion.dart';
import 'package:worka/employer_page/plan_price_android.dart';
import 'package:worka/interfaces/login_interface.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/dashboard_work/profile.dart';
import 'package:worka/phoenix/model/MySkill.dart';
import 'package:worka/screens/login_screen.dart';
import 'package:worka/screens/selection_page.dart';
import '../employer_page/plan_price.dart';
import '../screens/help_center.dart';
import 'dashboard_work/interview/interviewScreen.dart';
import 'dashboard_work/skills/add-skill.dart';
import 'dashboard_work/preview.dart';
import 'model/Constant.dart';

// ignore: camel_case_types
class Work_Experience extends StatelessWidget {
  final richTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _editCompanyProfile(context),
        ),
      ),
    );
  }
}

var pages;
bool isready = false;

Widget imageView(String avatar, {callBack}) => Container(
    width: double.infinity,
    child: Stack(children: [
      Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.transparent,
                border: Border.all(
                    color: Color(0xff0D30D9).withOpacity(.15), width: 1.5)),
            child: CircleAvatar(
              backgroundImage: NetworkImage('$avatar'),
              radius: 45,
            ),
          )),
      callBack != null
          ? Positioned(
              bottom: 0,
              left: 60,
              right: 0,
              top: 70,
              child: IconButton(
                  onPressed: () => callBack(),
                  icon: Icon(
                    Icons.photo_camera,
                    color: Color(0xff0D30D9),
                    size: 28,
                  )))
          : Container()
    ]));

// ignore: unused_element
Widget skills(BuildContext context, {callBack}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Text('Skills',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9))),
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
          child: Text('Skills',
              style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Color(0xff0D30D9),
                  decoration: TextDecoration.none)),
        ),
        SizedBox(
          height: 10.0,
        ),
        FutureBuilder(
            builder: (ctx, snapshot) => _container(snapshot),
            future: context.read<Controller>().viewSkills()),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              width: 300,
              child: GeneralButtonContainer(
                name: 'Add Skills',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () => Get.to(() => AddSkills()),
                paddingBottom: 3,
                paddingLeft: 10,
                paddingRight: 10,
                paddingTop: 5,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );

Widget _container(snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Expanded(child: Center(child: CircularProgressIndicator()));
  } else if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
      return const Text('Error');
    } else if (snapshot.hasData) {
      List<MySkill> m = snapshot.data;
      return Expanded(
          child: ListView.builder(
              itemCount: m.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) => _skillAndExperience(ctx, m[i])));
    } else {
      return const Text('Empty data');
    }
  } else {
    return Text('State: ${snapshot.connectionState}');
  }
}

// ignore: unused_element
Widget selectLanguage(BuildContext context, TextEditingController c) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () => Get.back(),
            ),
          ),
          Text('Language',
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
        const SizedBox(height: 20.0),
        imageView('${context.watch<Controller>().avatar}'),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Select Language',
              style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Color(0xff0D30D9),
                  decoration: TextDecoration.none)),
        ),
        SizedBox(
          height: 10.0,
        ),
        CustomAutoText(context, 'select Language', 'Language', c),
        SizedBox(
          height: 10.0,
        ),
        CustomDropDownLanguage(
            ['Fluent', 'Native', 'Beginner', 'Conversational'],
            'Level',
            'Language level',
            (s) => context.read<Controller>().setLang(s)),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: context.watch<Controller>().isLoading
              ? Center(child: CircularProgressIndicator())
              : GeneralButtonContainer(
                  name: 'Add Language',
                  color: Color(0xff0D30D9),
                  textColor: Colors.white,
                  onPress: () => context.read<Controller>().addLanguage(c.text),
                  paddingBottom: 3,
                  paddingLeft: 10,
                  paddingRight: 10,
                  paddingTop: 5,
                ),
        ),
      ],
    );
// ignore: unused_element
Widget _selectAvailablity(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        imageView('${context.watch<Controller>().avatar}'),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Select Availablity',
              style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Color(0xff0D30D9),
                  decoration: TextDecoration.none)),
        ),
        SizedBox(
          height: 10.0,
        ),
        CustomDropDown(OCCUPATION),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              width: 300,
              child: GeneralButtonContainer(
                name: 'Update Availablity',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () {},
                paddingBottom: 3,
                paddingLeft: 10,
                paddingRight: 10,
                paddingTop: 5,
              ),
            ),
          ),
        ),
      ],
    );
// ignore: unused_element
Widget _additionalInformation(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        imageView('${context.watch<Controller>().avatar}'),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Additional Information',
              style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Color(0xff0D30D9),
                  decoration: TextDecoration.none)),
        ),
        SizedBox(
          height: 10.0,
        ),
        CustomRichTextForm(
            null, null, 'start typin here', TextInputType.text, 16),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              width: 300,
              child: GeneralButtonContainer(
                name: 'Add Info',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () {},
                paddingBottom: 3,
                paddingLeft: 10,
                paddingRight: 10,
                paddingTop: 5,
              ),
            ),
          ),
        ),
      ],
    );
//=====================================================================================================
// ignore: unused_element
Widget interviewStep4(ctx, ctrl) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //custom app design
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('Questions',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
              textAlign: TextAlign.center),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                  '${Provider.of<Controller>(ctx, listen: true).counter} of 3',
                  style: GoogleFonts.montserrat(
                      fontSize: 13, color: Colors.black26),
                  textAlign: TextAlign.center))
        ]),
        SizedBox(height: 30.0),
        //end of app bar design

        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //greeting oluwatomi
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Answer the Question below',
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        Provider.of<Controller>(ctx, listen: false).questions[
                            Provider.of<Controller>(ctx, listen: true).counter -
                                1],
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Colors.black38),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              //the guides
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Answer:',
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Color(0xff0D30D9)),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomRichTextForm(ctrl, null, 'Type your answer here',
                        TextInputType.text, 16)
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(ctx).size.width,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Add More +',
                        style:
                            GoogleFonts.montserrat(color: Color(0xff0D30D9)))),
              ),
              SizedBox(
                height: 40.0,
              ),

              Container(
                width: MediaQuery.of(ctx).size.width,
                child: Provider.of<Controller>(ctx, listen: false).counter >= 3
                    ? GeneralButtonContainer(
                        name: 'Preview',
                        color: Color(0xff0D30D9),
                        textColor: Colors.white,
                        onPress: () => Navigator.push(
                            ctx,
                            MaterialPageRoute(
                                builder: (context) => Screens(_preview(
                                    ctx,
                                    Provider.of<Controller>(ctx, listen: false)
                                        .answers)))),
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: Provider.of<Controller>(ctx, listen: true)
                                        .counter ==
                                    1
                                ? null
                                : () =>
                                    Provider.of<Controller>(ctx, listen: false)
                                        .decrement(ctrl),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      Provider.of<Controller>(ctx, listen: true)
                                                  .counter ==
                                              1
                                          ? Colors.grey.withOpacity(.2)
                                          : Color(0xff0D30D9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Center(
                                    child: Icon(Icons.arrow_back_ios,
                                        color: Provider.of<Controller>(ctx,
                                                        listen: true)
                                                    .counter ==
                                                1
                                            ? Colors.grey
                                            : Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Provider.of<Controller>(ctx, listen: false)
                                    .increment(ctrl),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff0D30D9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Center(
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        )
      ],
    );
// ignore: unused_element
Widget _preview(ctx, answer) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //custom app design
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('Preview',
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
        SizedBox(height: 30.0),
        //end of app bar design

        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    //the guides
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Answer:',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ...List.generate(
                              answer.length,
                              (index) => Column(
                                    children: [
                                      Text(
                                        '${index + 1}.  ${answer[index]}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            color: Colors.black38),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ))
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40.0,
                    ),

                    Container(
                      width: MediaQuery.of(ctx).size.width,
                      child: GeneralButtonContainer(
                        name: 'Preview',
                        color: Color(0xff0D30D9),
                        textColor: Colors.white,
                        onPress: () {},
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
// ignore: unused_element
Widget _interviewSuccess(BuildContext ctx) => Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: Color(0xff0D30D9).withOpacity(.2)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('success.png'),
            SizedBox(height: 5.0),
            Text('Interview Completed',
                style: GoogleFonts.montserrat(
                    color: Color(0xff0D30D9),
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w900))
          ],
        ),
      ),
    );
//=====================================================================================================
//INTERVIEW QUESTIONS ANSWER (EMPLOYEE)
// ignore: unused_element
// ignore: unused_element
Widget _interviewPreview(BuildContext context) => Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text(
            'Preview',
            style:
                GoogleFonts.montserrat(fontSize: 18, color: Color(0xff0D30D9)),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(null),
              color: Colors.black,
              onPressed: () {},
            ),
          )
        ]),
        SizedBox(height: 10.0),
        //end of app bar design

        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //the guides
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proof read your interview questions before posting',
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '1. Let’s meet you again and let us know about your core strenght, past experience; In summary?',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '2. Tell us what your strenght and weakness are?',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '3. What are your past experiences regarding this job role?',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '4. Ask Questions relating to the job role.',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '5. Ask for renumeration range.',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 70.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: GeneralButtonContainer(
                      name: 'Upload Question',
                      color: Color(0xff0D30D9),
                      textColor: Colors.white,
                      onPress: () {},
                      paddingBottom: 3,
                      paddingLeft: 10,
                      paddingRight: 10,
                      paddingTop: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        )
      ],
    );
//for 3 views
// ignore: unused_element
Widget interviewEmployer({ctx, ctrl}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //custom app design
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('Interview Questions',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
              textAlign: TextAlign.center),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('1 of 3',
                  style: GoogleFonts.montserrat(
                      fontSize: 13, color: Colors.black26),
                  textAlign: TextAlign.center))
        ]),
        SizedBox(height: 30.0),
        //end of app bar design

        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //the guides
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Answer:',
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Color(0xff0D30D9)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 1.0,
                              color: Color(0xff0D30D9).withOpacity(.2)),
                        ),
                        child: RichText(
                          text: TextSpan(
                              text:
                                  '1. Let’s meet you again and let us know about your core strenght, past experience; In summary?\n\n',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, color: Colors.grey),
                              children: [
                                TextSpan(
                                  text:
                                      '2. Tell us what your strenght and weakness are?\n\n',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                TextSpan(
                                  text:
                                      '3. What are your past experiences regarding this job role?\n\n',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                TextSpan(
                                  text:
                                      '4. Ask Questions relating to the job role.\n\n',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                TextSpan(
                                  text: '5. Ask for renumeration range.\n\n',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(ctx).size.width,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Add More +',
                        style:
                            GoogleFonts.montserrat(color: Color(0xff0D30D9)))),
              ),
              SizedBox(
                height: 40.0,
              ),

              Container(
                width: MediaQuery.of(ctx).size.width,
                child: Provider.of<Controller>(ctx, listen: false).counter < 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Provider.of<Controller>(ctx, listen: false)
                                    .decrement(ctrl),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff0D30D9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Center(
                                    child: Icon(Icons.arrow_back_ios,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Provider.of<Controller>(ctx, listen: false)
                                    .increment(ctrl),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff0D30D9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Center(
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      )
                    : GeneralButtonContainer(
                        name: 'Preview',
                        color: Color(0xff0D30D9),
                        textColor: Colors.white,
                        onPress: () {},
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        )
      ],
    );
// ignore: unused_element
Widget addOptions(BuildContext context) => Column(
      children: [
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('Add Options',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
              textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(null),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
        ]),
        SizedBox(height: 30.0),
        ...List.generate(3, (index) => QuestionList(context)),
        SizedBox(height: 30.0),
        GeneralButtonContainer(
          name: 'Add option',
          color: Color(0xff0D30D9),
          textColor: Colors.white,
          onPress: () {},
          paddingBottom: 3,
          paddingLeft: 30,
          paddingRight: 30,
          paddingTop: 5,
        ),
      ],
    );
//==========================New row==================================================================
Widget interviewStep7(BuildContext context, String Id, String note, {type}) =>
    Column(
      children: [
        //custom app design
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () => Get.back(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(null),
              color: Colors.black,
              onPressed: () {},
            ),
          )
        ]),
        SizedBox(height: 30.0),
        //end of app bar design
        Expanded(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //greeting oluwatomi
                  Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hi, ${context.watch<Controller>().userNames}',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Upload your Interview test\nQuestions for the job role.',
                            style: GoogleFonts.montserrat(
                                fontSize: 17, color: DEFAULT_COLOR),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  //the guides
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Here are some example of what your interview questions should entails',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          '${note}',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black38,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        width: 300,
                        child: GeneralButtonContainer(
                          name: 'Start',
                          color: Color(0xff0D30D9),
                          textColor: Colors.white,
                          onPress: () {
                            if (type == 'theory') {
                              Get.to(() => TheoryQuestion(Id));
                            } else {
                              Get.to(() => EmpObjQuestions(Id));
                            }
                          },
                          paddingBottom: 3,
                          paddingLeft: 10,
                          paddingRight: 10,
                          paddingTop: 5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ]),
          ),
        )
      ],
    );
// ignore: unused_element //create new controller logic
Widget interviewStep8(BuildContext context) => Column(
      children: [
        //custom app design
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('Text',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
              textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IconButton(
              icon: Icon(null),
              color: Colors.black,
              onPressed: () {},
            ),
          )
        ]),
        SizedBox(height: 30.0),
        //end of app bar design

        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //greeting oluwatomi

              //the guides
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        'Objective test:',
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Color(0xff0D30D9)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextForm(
                        null,
                        '1.  How do you know a successful project?',
                        '',
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, top: 7.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Answer C',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          Text(
                            'Add option +',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CustomTextForm(
                        null,
                        '1.  How do you know a successful project?',
                        '',
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, top: 7.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Answer B',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          Text(
                            'Add option +',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CustomTextForm(
                        null,
                        '1.  How do you know a successful project?',
                        '',
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, top: 7.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Answer A',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          Text(
                            'Add option +',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CustomTextForm(
                        null,
                        '1.  How do you know a successful project?',
                        '',
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, top: 7.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Answer B',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          Text(
                            'Add option +',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CustomTextForm(
                        null,
                        '1.  How do you know a successful project?',
                        '',
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, top: 7.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Answer B',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                          Text(
                            'Add option +',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Color(0xff0D30D9)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child:
                    Provider.of<Controller>(context, listen: false).counter < 3
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xff0D30D9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Center(
                                        child: Icon(Icons.arrow_back_ios,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xff0D30D9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Center(
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          )
                        : GeneralButtonContainer(
                            name: 'Preview',
                            color: Color(0xff0D30D9),
                            textColor: Colors.white,
                            onPress: () {},
                            paddingBottom: 3,
                            paddingLeft: 30,
                            paddingRight: 30,
                            paddingTop: 5,
                          ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        )
      ],
    );
// ignore: unused_element
Widget postJobs(BuildContext context, GlobalKey<ScaffoldState> scaffold) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon:
                      Icon(Icons.keyboard_backspace, color: Color(0xff0D30D9))),
              Text('Applied Jobs',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: DEFAULT_COLOR)),
              IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.more_vert),
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(0.0)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      ...List.generate(
                          context.watch<Controller>().myJobsModel!.length,
                          (index) => JobPostingList(context,
                              context.watch<Controller>().myJobsModel![index]))
                    ]),
              )),
        )
      ],
    );

Widget _jobPosting1of2(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () {},
              ),
            ),
            Text('Job Posting',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(null),
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ]),
          SizedBox(height: 20.0),
          Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('1 of 3',
                    style: GoogleFonts.montserrat(
                        fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.start),
              ),
            ),
            SizedBox(height: 5.0),
            CustomTextForm(
                null, 'UX/UI Designer', 'Job title', TextInputType.text),
            SizedBox(height: 5.0),
            CustomRichTextForm(null, 'Job Description', 'Job description',
                TextInputType.text, 14),
            SizedBox(height: 5.0),
            CustomDropDown(OCCUPATION),
            SizedBox(height: 5.0),
            CustomDropDown(OCCUPATION),
            SizedBox(height: 5.0),
            CustomDropDown(OCCUPATION),
            SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GeneralButtonContainer(
                name: 'Next',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () {},
                paddingBottom: 3,
                paddingLeft: 30,
                paddingRight: 30,
                paddingTop: 5,
              ),
            ),
            SizedBox(height: 30.0),
          ]))
        ],
      ),
    );

Widget _jobPosting2of2(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () {},
              ),
            ),
            Text('Job Posting',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: IconButton(
                icon: Icon(null),
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ]),
          SizedBox(height: 20.0),
          Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('2 of 3',
                    style: GoogleFonts.montserrat(
                        fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.start),
              ),
            ),
            SizedBox(height: 5.0),
            CustomTextForm(
                null, 'Health, Free Seminar', 'Benefit', TextInputType.text),
            SizedBox(height: 5.0),
            CustomRichTextForm(null, 'Job Requirements', 'Job requirements',
                TextInputType.text, 14),
            SizedBox(height: 5.0),
            CustomDropDown(OCCUPATION),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Radio(
                    value: '',
                    groupValue: 'remote',
                    onChanged: (value) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('remote',
                        style: GoogleFonts.montserrat(
                            fontSize: 12, color: Color(0xff0D30D9))),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GeneralButtonContainer(
                name: 'Upload logo',
                color: Color(0xFFFFFFFF),
                textColor: Color(0xff0D30D9),
                onPress: () {},
                paddingBottom: 3,
                paddingLeft: 30,
                paddingRight: 30,
                paddingTop: 5,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GeneralButtonContainer(
                name: 'Next',
                color: Color(0xff0D30D9),
                textColor: Colors.white,
                onPress: () {},
                paddingBottom: 3,
                paddingLeft: 30,
                paddingRight: 30,
                paddingTop: 5,
              ),
            ),
            SizedBox(height: 30.0),
          ]))
        ],
      ),
    );

Widget _categoryWidget(BuildContext context) => Column(
      children: [
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: IconButton(
              icon: Icon(Icons.cancel),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: SearchWidget(null, 'Search for job categories'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(
              icon: Icon(null),
              color: Colors.black,
              onPressed: () {},
            ),
          )
        ]),
        SizedBox(height: 10.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    Provider.of<Controller>(context, listen: false)
                        .stateList
                        .length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .stateList[index],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ))
              ],
            ),
          ),
        )
      ],
    );

Widget _previewJob(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () {},
              ),
            ),
            Text('Preview',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
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
          SizedBox(height: 10.0),
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Image(
                    image: NetworkImage(
                        'http://assets.stickpng.com/images/5954bb45deaf2c03413be353.png'),
                    width: 100,
                    height: 100),
                Text('UX/UI Designer',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center),
                Text('Remote, Nigeria',
                    style: GoogleFonts.montserrat(
                        fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center),
                SizedBox(height: 30.0),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Job Description',
                            style: GoogleFonts.montserrat(
                                fontSize: 13, color: Colors.black),
                            textAlign: TextAlign.center),
                        SizedBox(height: 10.0),
                        Text(
                            'An expert who can design a functional and appealing user experience and interface design is urgently needed. We are looking for a graphic  designer to work on ad hoc projects to support our brand marketing team. ',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.left),
                        SizedBox(height: 20.0),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('Requirements:',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Icon(Icons.panorama_fisheye_outlined,
                                        color: Color(0xff0D30D9), size: 6),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11.0),
                                      child: Text(
                                          ' 2-3 years of experience as a UI/UX designer',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(Icons.panorama_fisheye_outlined,
                                        color: Color(0xff0D30D9), size: 6),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11.0),
                                      child: Text(
                                          ' 2-3 years of experience as a UI/UX designer',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13, color: Colors.grey),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('Benefits:',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Icon(Icons.panorama_fisheye_outlined,
                                        color: Color(0xff0D30D9), size: 6),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11.0),
                                      child: Text(' #250k-400 monthly',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(Icons.panorama_fisheye_outlined,
                                        color: Color(0xff0D30D9), size: 6),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11.0),
                                      child: Text(' Access to Design Resources',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13, color: Colors.grey),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(Icons.panorama_fisheye_outlined,
                                        color: Color(0xff0D30D9), size: 6),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11.0),
                                      child: Text(' Free Seminars',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13, color: Colors.grey),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                SizedBox(height: 40.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: GeneralButtonContainer(
                    name: 'Post Job',
                    color: Color(0xff0D30D9),
                    textColor: Colors.white,
                    onPress: () {},
                    paddingBottom: 3,
                    paddingLeft: 30,
                    paddingRight: 30,
                    paddingTop: 5,
                  ),
                ),
                SizedBox(height: 30.0),
              ]))
        ],
      ),
    );

Widget accept_and_interview(BuildContext context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.menu),
            color: Color(0xff0D30D9),
            onPressed: () {},
          ),
        ),
        Text('Application',
            style:
                GoogleFonts.montserrat(fontSize: 18, color: Color(0xff0D30D9)),
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Radio(
              toggleable: true,
              value: true,
              groupValue: 'select_all',
              onChanged: (status) {},
            ),
            Text('Select all',
                style: GoogleFonts.montserrat(
                    fontSize: 11, color: Color(0xff0D30D9)),
                textAlign: TextAlign.start),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10.0),
            ...List.generate(5, (index) => Accept_and_Interview(context))
          ],
        ),
      )
    ]);

Widget _shortList(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Text('ShortList',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Radio(
                toggleable: true,
                value: true,
                groupValue: 'select_all',
                onChanged: (status) {},
              ),
              Text('Select all',
                  style: GoogleFonts.montserrat(
                      fontSize: 11, color: Color(0xff0D30D9)),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
        Expanded(
            child: Column(
          children: [...List.generate(10, (index) => shortList(context))],
        ))
      ],
    );

Widget _companyProfile(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Color(0xff0D30D9),
                onPressed: () {},
              ),
            ),
            Text('Company profile',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
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
          SizedBox(height: 10.0),
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Image(
                    image: NetworkImage(
                        'http://assets.stickpng.com/images/5954bb45deaf2c03413be353.png'),
                    width: 100,
                    height: 100),
                SizedBox(height: 30.0),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shell.com',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center),
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Color(0xff0D30D9),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Text('Lagos, Nigeria',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.left),
                        SizedBox(height: 5.0),
                        Text('info@shell.com.com',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.left),
                        SizedBox(height: 5.0),
                        Text('+234 9067618720',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.left),
                        SizedBox(height: 25.0),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Text('Company profile',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Text(
                                      'We are a global group of energy and petrochemical\ncompanies with more than 80,000 employees in more than\n70 countries. We use advanced technologies and take an\ninnovative approach to help build a sustainable energy future.',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.start),
                                ),
                                SizedBox(height: 4.0),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Text('Reviews:',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Text('4.6 of 5.0 Ratings',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 4.0),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            ))
                      ],
                    )),
              ]))
        ],
      ),
    );

Widget alerts(BuildContext context) => Column(
      children: [
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () {},
            ),
          ),
          Flexible(
            child: AutoSizeText('Alert',
                minFontSize: 12,
                maxFontSize: 18,
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9)),
                textAlign: TextAlign.center),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(null),
          )
        ]),
        SizedBox(height: 30.0),
        Expanded(
          child: context.watch<Controller>().alertList.length > 0
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    ...List.generate(
                        context.watch<Controller>().alertList.length,
                        (index) => AlertList(context, index))
                  ],
                ))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        )
      ],
    );

Widget _editCompanyProfile(BuildContext context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 10.0),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            color: Color(0xff0D30D9),
            onPressed: () {},
          ),
        ),
        Text('Company profile',
            style:
                GoogleFonts.montserrat(fontSize: 18, color: Color(0xff0D30D9)),
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
      SizedBox(height: 10.0),
      Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(
          children: [
            Image(
                image: NetworkImage(
                    'http://assets.stickpng.com/images/5954bb45deaf2c03413be353.png'),
                width: 100,
                height: 100),
            Positioned(
              top: 60,
              right: 0,
              child: CircleAvatar(
                  radius: 20,
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.camera))),
            )
          ],
        ),
        SizedBox(height: 20.0),
      ])),
      Expanded(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Company Information',
                style: GoogleFonts.montserrat(
                    fontSize: 16, color: Color(0xff0D30D9))),
          ),
          SizedBox(height: 5.0),
          CustomTextForm(null, 'Example.com', 'Name', TextInputType.text),
          CustomTextForm(
              null, 'info@shell.com.ng', 'E-mail', TextInputType.text),
          CustomTextForm(
              null, 'Lagos, Nigeria', 'Location', TextInputType.text),
          CustomRichTextForm(
              null,
              'We are a global group of energy and petrochemical companies with more than 80,000 employees in more than 70 countries. We use advanced technologies and take an innovative approach to help build a sustainable energy future.',
              'Company Profile',
              TextInputType.text,
              16),
          CustomTextForm(
              null, '+234 906761 8749', 'Phone Number', TextInputType.text),
          SizedBox(height: 25.0),
          Container(
            width: MediaQuery.of(context).size.width,
            child: GeneralButtonContainer(
              name: 'Upload Bio',
              color: Color(0xff0D30D9),
              textColor: Colors.white,
              onPress: () {},
              paddingBottom: 3,
              paddingLeft: 30,
              paddingRight: 30,
              paddingTop: 5,
            ),
          ),
          SizedBox(height: 25.0),
        ]),
      ))
    ]);

Widget _skillAndExperience(BuildContext context, MySkill skill) => Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color(0xff0D30D9).withOpacity(.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${skill.skillName}',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.0),
          Text('Proficiency: ${skill.level}',
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black)),
          SizedBox(height: 10.0),
          Text('${skill.yearOfExperience} years experienced',
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black)),
          SizedBox(height: 8.0),
        ],
      ),
    );

Widget termOfUse(BuildContext context) => Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () => Get.back(),
            ),
          ),
          Text('',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset('assets/editted.png',
                                width: 50, height: 50, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Term of use',
                                style: GoogleFonts.lato(
                                    fontSize: 26,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'updated 8/4/2022',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13.5,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Term and Condition\nfor Candidate/Employee',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        TERM1,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Term and Condition\nfor Company/Employer',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        TERM2,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Features Plan',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        TERM3,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Disclaimer',
                        style: GoogleFonts.lato(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        TERM4,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(5, 13, 48, 217),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'For More Enquiry or Information',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'visit our website: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.5,
                                height: 1.5,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'www.workanetwork.com',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.5,
                                height: 1.5,
                                color: DEFAULT_COLOR,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Text(
                        'About Workanetworks',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'User Agreement',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        '© Workanetworks inc 2022',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                    ],
                  ))
            ],
          ),
        ))
      ],
    );

Widget about(BuildContext context) => Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () => Get.back(),
            ),
          ),
          Text('',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset('assets/editted.png',
                                width: 50, height: 50, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Workanetworks',
                                style: GoogleFonts.lato(
                                    fontSize: 26,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        ABOUT1,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Our Company History',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        ABOUT2,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'What We Do',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        ABOUT3,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Mission',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        ABOUT4,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Vision',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        ABOUT5,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Values',
                        style: GoogleFonts.lato(
                            fontSize: 19,
                            color: DEFAULT_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        ABOUT6,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(5, 13, 48, 217),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'For More Enquiry or Information',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'visit our website: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.5,
                                height: 1.5,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'www.workanetwork.com',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.5,
                                height: 1.5,
                                color: DEFAULT_COLOR,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Text(
                        'About Workanetworks',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'User Agreement',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        '© Workanetworks inc 2022',
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                    ],
                  ))
            ],
          ),
        ))
      ],
    );

Widget privacy(BuildContext context) => Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              color: Color(0xff0D30D9),
              onPressed: () => Get.back(),
            ),
          ),
          Text('',
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Color(0xff0D30D9)),
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset('assets/editted.png',
                                width: 50, height: 50, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Privacy Policy',
                                style: GoogleFonts.lato(
                                    fontSize: 26,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'updated 8/4/2022',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12.5,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Code Of Conduct Policy',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        PRIVACY1,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Recuitment Policy',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: DEFAULT_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        PRIVACY2,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Training And Development Policy',
                        style: GoogleFonts.lato(
                          fontSize: 19,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        PRIVACY3,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                    ]),
              )
            ],
          ),
        ))
      ],
    );

void CustomSnack(t, m) => Get.snackbar(t, m,
    messageText: Text('$m',
        style: GoogleFonts.montserrat(fontSize: 14.5, color: Colors.black)),
    colorText: Colors.black,
    duration: Duration(seconds: 1));

Widget getDrawer(BuildContext context, scaffold, {name, type}) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage('${context.watch<Controller>().avatar}'),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${context.watch<Controller>().userNames}',
                          textAlign: TextAlign.start,
                          maxFontSize: 19,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Employee',
                          style: GoogleFonts.montserrat(color: DEFAULT_COLOR),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          ListTile(
              title: Text('My Profile',
                  style: GoogleFonts.montserrat(fontSize: 16)),
              leading: const Icon(Icons.account_circle, color: DEFAULT_COLOR),
              onTap: () => Get.to(() => ProfileScreen())),
          ListTile(
            title: Text('My Jobs', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.work, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state of the app.
              Get.to(() => Screens(postJobs(context, scaffold)));
              // ...
            },
          ),
          ListTile(
            title:
                Text('Interviews', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.airplay_outlined, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => InterviewPage());
            },
          ),
          ListTile(
            title: Text('Skills', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.account_circle, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state of the app.
              Get.to(() => Screens(skills(context)));
              // ...
            },
          ),
          // ListTile(
          //   title: Text('Billing', style: GoogleFonts.montserrat(fontSize: 16)),
          //   leading: const Icon(Icons.payment, color: DEFAULT_COLOR),
          //   onTap: () {
          //     // Update the state of the app.
          //     Get.to(() => BillingPage());
          //     // ...
          //   },
          // ),
          ListTile(
            title:
                Text('Settings', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.settings, color: DEFAULT_COLOR),
            onTap: () => Get.to(() => EmployerSettings()),
          ),
          ListTile(
            title: Text('Help Center',
                style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.help, color: DEFAULT_COLOR),
            onTap: () {
              Get.to(() => Help_Center());
            },
          ),
          ListTile(
            title:
                Text('Sign Out', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.logout, color: DEFAULT_COLOR),
            onTap: () async {
              ILogin()
                  .logout()
                  .whenComplete(() => {Get.offAll(() => LoginScreen())});
              context.read<Controller>().logout();

              // ...
            },
          ),
        ],
      ),
    );

Widget getDrawer2(BuildContext context, scaffold) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage('${context.watch<Controller>().avatar}'),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${context.watch<Controller>().userNames}',
                          textAlign: TextAlign.start,
                          maxFontSize: 19,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Employer',
                          style: GoogleFonts.montserrat(color: DEFAULT_COLOR),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          ListTile(
            title: Text(
              'Company Profile',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            leading: const Icon(Icons.account_circle, color: DEFAULT_COLOR),
            onTap: () {
              Get.to(() => CompanyProfile());

              // ...
            },
          ),
          ListTile(
            title: Text('Applied Jobs',
                style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.work, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state of the app.
              Get.to(() => PostedJobs());
              // ...
            },
          ),
          ListTile(
            title:
                Text('Interviews', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.airplay_outlined, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state Getof the app.
              // ...
              Get.to(() => EmpInterview());
            },
          ),
          ListTile(
            title: Text('Plans', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.money, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state Getof the app.
              // ...
              if (Platform.isIOS)
                Get.to(() => PlanPrice());
              else
                Get.to(() => AndroidPlanPrice());
            },
          ),
          // ListTile(
          //   title: Text('Billing', style: GoogleFonts.montserrat(fontSize: 16)),
          //   leading: const Icon(Icons.payment, color: DEFAULT_COLOR),
          //   onTap: () {
          //     // Update the state Getof the app.
          //     // ...
          //     Get.to(() => BillingPage());
          //   },
          // ),
          ListTile(
            title:
                Text('Settings', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.settings, color: DEFAULT_COLOR),
            onTap: () => Get.to(() => EmployerSettings()),
          ),
          ListTile(
            title: Text('Help Center',
                style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.help, color: DEFAULT_COLOR),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => Help_Center());
            },
          ),
          ListTile(
            title:
                Text('Sign Out', style: GoogleFonts.montserrat(fontSize: 16)),
            leading: const Icon(Icons.logout, color: DEFAULT_COLOR),
            onTap: () {
              ILogin()
                  .logout()
                  .whenComplete(() => {Get.offAll(() => SelectionPage())});
              context.read<EmpController>().signOut();
              context.read<Controller>().logout();

              // ...
            },
          ),
        ],
      ),
    );

Widget profileItems(context, title, c, child, bool expand, {onTap}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        key: Key('$title'),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => c(),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('$title',
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
                InkWell(
                    onTap: () => onTap(),
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(Icons.add, color: DEFAULT_COLOR, size: 23)),
              ],
            ),
            expand
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: child,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );

selectPage(BuildContext c, Function inter, Function employ) => showDialog(
      context: c,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: GeneralButtonContainer(
                        name: 'Shorlist for interview',
                        color: DEFAULT_COLOR,
                        textColor: Colors.white,
                        onPress: () {
                          Navigator.pop(c);
                          inter();
                        },
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: GeneralButtonContainer(
                        name: 'Shorlist for employment',
                        color: DEFAULT_COLOR,
                        textColor: Colors.white,
                        onPress: () {
                          Navigator.pop(c);
                          employ();
                        },
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                      ),
                    ),
                  ])),
        );
      },
    );

Future<File> fromAsset(String asset, String filename) async {
  Completer<File> completer = Completer();
  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$filename');
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }
  return completer.future;
}

upgradePop(BuildContext c) => showDialog(
      context: c,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    Icon(Icons.warning, color: Colors.black, size: 40.0),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        CONTENT,
                        style: GoogleFonts.montserrat(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: GeneralButtonContainer(
                        name: 'Upgrade Plan',
                        color: DEFAULT_COLOR,
                        textColor: Colors.white,
                        onPress: () {
                          Navigator.pop(c);
                          Get.to(() => PlanPrice());
                        },
                        paddingBottom: 3,
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 5,
                        radius: 35.0,
                      ),
                    ),
                  ])),
        );
      },
    );
