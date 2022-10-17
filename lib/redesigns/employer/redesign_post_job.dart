import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/employer/preview_post_job.dart';

import '../../controllers/constants.dart';

class RePostJobs extends StatelessWidget {
  const RePostJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(children: [
         const SizedBox(height: 10.0,),
        Row(children: [
          const SizedBox(width: 20.0,),
           GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.keyboard_backspace, color: DEFAULT_COLOR,)),
          const SizedBox(width: 20.0,),
          Text('Post a Job', style: GoogleFonts.lato(fontSize: 19.0, color: Colors.black54),)
        ],),
        const SizedBox(height: 30.0,),
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                inputWidget(ctl: null),
                const SizedBox(height: 25.0,),
                inputWidget(text: 'Job Title', icons: Icons.shopping_basket, hint: 'Production Manager', ctl: null),
                const SizedBox(height: 25.0,),
                inputWidgetRich(ctl: null),
                const SizedBox(height: 25.0,),
                inputWidget(text: 'Job Requirements', icons: Icons.shopping_basket, hint: 'FullTime, Partime, Remote', ctl: null),
                const SizedBox(height: 25.0,),
                inputDropDown(['Boy', 'Girl'], callBack: (s) {}),
                const SizedBox(height: 25.0,),
                inputDropDown(['Boy', 'Girl'], text: 'Choose Budget', icons: Icons.shopping_bag, hint: '100k - 450k Monthly', callBack: (s) {}),
                 const SizedBox(height: 25.0,),
                inputDropDown(['Full-time', 'Part-time', 'Contract', 'Internship', 'Collaboration'], text: 'Input Job Type', icons: Icons.location_on, hint: 'FullTime', callBack: (s) {}),
                 const SizedBox(height: 25.0,),
                inputDropDown(OCCUPATION, text: 'Required Skills', icons: Icons.timelapse, hint: 'Search to add skills', callBack: (s) {}),
                const SizedBox(height: 45.0,),
                GestureDetector(
                  onTap: () async {},
                   child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.redAccent.withOpacity(.1)
                   ), child: Row(
                    children: [
                      Icon(Icons.file_open, color: Colors.redAccent,),
                      const SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Attach File', style: GoogleFonts.lato(color: Colors.black54, fontSize: 15.0),),
                          Text('Not more than 1MB', style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0),),
                        ],
                      )
                    ],
                   ),),
                 ),
                 const SizedBox(height: 25.0,),
                 GestureDetector(
                  onTap: () async {
                    Get.to(() => RePostJobsPreview());
                  },
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: DEFAULT_COLOR
                   ), child: Center(child: Text('Submit', style: GoogleFonts.lato(fontSize: 15.0, color: Colors.white),),)),
                 ),
                  const SizedBox(height: 25.0,),
              ],
            ),
          ),
        ))
      ],)),
    );
  }
}

Widget inputWidget({text = 'Company Name', icons = Icons.person, hint = 'ProLinks Company', ctl}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
          Icon(icons, color: Colors.black54,),
          const SizedBox(width: 20.0,),
          Text('$text', style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54, fontWeight: FontWeight.bold),)
        ],),
        const SizedBox(height: 10.0,),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(controller: ctl, 
          style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            hintStyle: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
            hintText: '$hint',
            border: OutlineInputBorder(borderSide: BorderSide.none)
          ),),
        )
    ],
  );
}

Widget inputWidgetRich({text = 'Job Description', icons = Icons.edit, hint = 'Type here', ctl}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
          Icon(icons, color: Colors.black54,),
          const SizedBox(width: 20.0,),
          Text('$text', style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54, fontWeight: FontWeight.bold),)
        ],),
        const SizedBox(height: 10.0,),
        Container(
          decoration: BoxDecoration(
            color: DEFAULT_COLOR.withOpacity(.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(controller: ctl, 
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            hintStyle: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),
            hintText: '$hint',
            border: OutlineInputBorder(borderSide: BorderSide.none)
          ),),
        )
    ],
  );
}

Widget inputDropDown(List<String> list, {text = 'Benefits', icons = Icons.shield_sharp, hint = 'Insurance', callBack}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
          Icon(icons, color: Colors.black54,),
          const SizedBox(width: 20.0,),
          Text('$text', style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54, fontWeight: FontWeight.bold),)
        ],),
        const SizedBox(height: 10.0,),
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
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
              ),
              // initialValue: 'Male',
              onChanged: (s) => callBack(s),
              hint: Text('$hint', style:  GoogleFonts.lato(fontSize: 17.0, color: Colors.black54)),
              items: list
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text('$s', style: GoogleFonts.lato(fontSize: 17.0, color: Colors.black54),),
                      ))
                  .toList(),
            ),
        )
    ],
  );
}