import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/controllers/constants.dart';
import 'package:worka/models/InboxModel.dart';
import 'package:worka/phoenix/dashboard_work/JobDetailsScreen.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:worka/phoenix/model/MyJobsModel.dart';

import 'Controller.dart';

Widget CustomTextForm(ctl, hintText, label, input,
        {onTap, bool read = false, horizontal = 20.0, format}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TextFormField(
              onTap: onTap,
              controller: ctl,
              readOnly: read,
              inputFormatters: format,
              style: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
              decoration: InputDecoration(
                filled: false,
                hintText: hintText,
                labelText: label == '' ? null : label,
                labelStyle: GoogleFonts.montserrat(
                    fontSize: 15.0, color: Colors.black54),
                hintStyle:
                    GoogleFonts.montserrat(fontSize: 14.0, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              keyboardType: input,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );

Widget CustomAutoText(BuildContext context, hint, label, ctl) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TypeAheadField<String?>(
              suggestionsBoxController: SuggestionsBoxController(),
              hideSuggestionsOnKeyboardHide: true,
              noItemsFoundBuilder: (context) => Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('No Data Found',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 12)),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await LanguageClass.getLocalLanguage(pattern);
              },
              onSuggestionSelected: (suggestion) {
                ctl.text = suggestion;
              },
              itemBuilder: (ctx, String? suggestion) => ListTile(
                title: Text('$suggestion',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.grey)),
              ),
              textFieldConfiguration: TextFieldConfiguration(
                controller: ctl,
                autofocus: false,
                style:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
                decoration: InputDecoration(
                  filled: false,
                  hintText: hint,
                  labelText: label == '' ? null : label,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.black54),
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 14.0, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget CustomAutoGeneral(BuildContext context, hint, label, ctl, function) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TypeAheadField<String?>(
              suggestionsBoxController: SuggestionsBoxController(),
              hideSuggestionsOnKeyboardHide: true,
              noItemsFoundBuilder: (context) => Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('No Data Found',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 12)),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await LanguageClass.getLocalOccupation(pattern);
              },
              onSuggestionSelected: (suggestion) {
                ctl.text = suggestion;
              },
              itemBuilder: (ctx, String? suggestion) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                title: Text('$suggestion',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey)),
              ),
              textFieldConfiguration: TextFieldConfiguration(
                controller: ctl,
                autofocus: false,
                style:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
                decoration: InputDecoration(
                  filled: false,
                  hintText: hint,
                  labelText: label == '' ? null : label,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.black54),
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 14.0, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget CustomDropDown(List<String> list,
        {callBack,
        width = double.infinity,
        name,
        hint,
        right = 20.0,
        left = 20.0}) =>
    Padding(
      padding: EdgeInsets.only(right: right, left: left, top: 5.0, bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: FormBuilderDropdown(
              name: '$name',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                labelText: '$name',
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
              onChanged: (s) => callBack(s),
              hint: Text('$hint'),
              items: list
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text('$s'.toUpperCase()),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );

Widget Accept_and_Interview(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.blue.withOpacity(.06),
            offset: Offset.zero,
            blurRadius: 3,
            spreadRadius: 5),
        BoxShadow(
            color: Colors.blue.withOpacity(.06),
            offset: Offset.zero,
            blurRadius: 10,
            spreadRadius: .1),
      ]),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.blue.withOpacity(.2),
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Oluwatobi Ogunjimi applied to your Job posting\n',
                      style:
                          GoogleFonts.lato(color: Colors.black, fontSize: 11),
                      children: [
                    TextSpan(
                        text: 'UX/UI Designer',
                        style: GoogleFonts.lato(
                            color: Colors.blue.shade200, fontSize: 11)),
                    TextSpan(
                        text: '  job in Lagos.',
                        style:
                            GoogleFonts.lato(color: Colors.black, fontSize: 11))
                  ])),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('September 2021,',
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 12)),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.red.shade100.withOpacity(.8),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text('Decline',
                        style: GoogleFonts.lato(
                            color: Colors.red.shade200, fontSize: 12)),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF0039A5).withOpacity(.8),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text('Accept',
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: 12)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );

Widget CategoryWidget(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.0),
          Text('Accounting & Banking',
              style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 10.0),
          Divider(
            height: 1,
            color: Colors.blue.withOpacity(.2),
            thickness: 1.0,
          ),
          ...List.generate(3, (index) => _childItem('Bank Cashier'))
        ],
      ),
    );

Widget _childItem(name) => Column(
      children: [
        SizedBox(height: 13.0),
        GestureDetector(
          onTap: () {
            // ignore: avoid_print
            print(name);
          },
          child: Text(
            name,
            style: GoogleFonts.lato(fontSize: 12, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );

Widget CustomRichTextForm(ctl, hintText, label, input, maxLines,
        {horizontal = 20.0,
        onSaved = null,
        onChange = null,
        read = false,
        color = Colors.white}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TextFormField(
                controller: ctl,
                maxLines: maxLines,
                readOnly: read,
                style:
                    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: hintText,
                  labelText: label,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 9.9, vertical: 9.9),
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
                keyboardType: input,
                onChanged: (s) => onChange(s)),
          ),
        ],
      ),
    );

Widget QuestionList(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 1.0, color: Colors.blue.withOpacity(.2))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('a.',
                  style: GoogleFonts.lato(fontSize: 12, color: Colors.black45)),
              SizedBox(height: 10.0),
              Text('b.',
                  style: GoogleFonts.lato(fontSize: 12, color: Colors.black45)),
              SizedBox(height: 10.0),
              Text('c.',
                  style: GoogleFonts.lato(fontSize: 12, color: Colors.black45))
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Radio(
            value: '',
            groupValue: 'question_list',
            onChanged: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('option',
                style: GoogleFonts.lato(fontSize: 12, color: Colors.blue)),
          ),
        ]),
      ],
    );

Widget SearchWidget(ctl, hintText) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: TextFormField(
              controller: ctl,
              style: GoogleFonts.lato(fontSize: 13.0, color: Colors.grey),
              decoration: InputDecoration(
                filled: false,
                hintText: hintText,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                hintStyle: GoogleFonts.lato(fontSize: 13.0, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              keyboardType: TextInputType.text,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );

Widget shortList(BuildContext context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: NetworkImage(
                      'https://i1.sndcdn.com/avatars-000317879260-4xyxxd-t500x500.jpg'),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Oluwatobi OgunJimi',
                      style:
                          GoogleFonts.lato(color: Colors.black, fontSize: 12)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('UX/UI Designer',
                      style: GoogleFonts.lato(color: Colors.blue, fontSize: 12))
                ],
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.6),
                borderRadius: BorderRadius.circular(10)),
            child: Text('Accept',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 12)),
          )
        ],
      ),
    );

Widget JobPostingList(BuildContext context, MyJobsModel myJobsModel) =>
    Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.blue.withOpacity(.2)),
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.0),
        onTap: () async {
          if (context.read<Controller>().type == 'employee')
            Get.to(() => JobDetailsScreen(myJobsModel.job.jobKey));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  backgroundImage:
                      NetworkImage('${myJobsModel.job.employer.companyLogo}'),
                ),
                SizedBox(height: 5.0),
                Text('${myJobsModel.job.title}',
                    style: GoogleFonts.lato(fontSize: 14, color: Colors.black)),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: AutoSizeText(
                      '${myJobsModel.job.currency.toUpperCase()}/${myJobsModel.job.budget}/${myJobsModel.job.salary_type}',
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.black)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('${myJobsModel.job.location}',
                  style: GoogleFonts.lato(fontSize: 12, color: Colors.grey)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: myJobsModel.status == 'processing'
                      ? Colors.blue.withOpacity(.5)
                      : myJobsModel.status == 'decline'
                          ? Colors.red.withOpacity(.5)
                          : Colors.green.withOpacity(.5),
                  borderRadius: BorderRadius.circular(5)),
              child: Text('${myJobsModel.status}',
                  style: GoogleFonts.montserrat(
                      fontSize: 12.5, color: Colors.white)),
            )
          ],
        ),
      ),
    );

Widget AlertList(BuildContext context, index) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
          left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: DEFAULT_COLOR.withOpacity(.06),
            offset: Offset.zero,
            blurRadius: 3,
            spreadRadius: 3),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 15,
                child: Icon(Icons.message, color: Colors.white, size: 16),
                backgroundColor: DEFAULT_COLOR.withOpacity(.3),
              ),
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ReadMoreText(
                    '${context.watch<Controller>().alertList[index].message}'
                        .trim(),
                    trimLines: 2,
                    colorClickableText: DEFAULT_COLOR,
                    trimMode: TrimMode.Line,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 13.5,
                    ),
                    trimCollapsedText: '\nShow more',
                    trimExpandedText: '\nShow less',
                    moreStyle: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                    lessStyle: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ),
              // Flexible(
              //   child: IconButton(
              //       onPressed: () {
              //         context.read<Controller>().deleteAlert(index);
              //       },
              //       icon: Icon(Icons.cancel, color: Colors.blue)),
              // ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
              '${DateFormat('yyyy-MM-dd hh:mm a').format(context.watch<Controller>().alertList[index].created)}',
              style: GoogleFonts.lato(color: Colors.grey, fontSize: 12))
        ],
      ),
    );

Widget CustomSearchForm(hintText, input, {ctl, onChange}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TextFormField(
              controller: ctl,
              onChanged: (s) => onChange(s),
              style: GoogleFonts.montserrat(fontSize: 14.0, color: Colors.grey),
              decoration: InputDecoration(
                filled: false,
                suffixIcon: Icon(
                  Icons.search,
                  size: 15,
                ),
                hintText: hintText,
                hintStyle:
                    GoogleFonts.montserrat(fontSize: 12.0, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              keyboardType: input,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );

Widget CustomAuthForm(hintText, String label, input,
        {ctl, right = 20.0, left = 20.0}) =>
    Padding(
      padding: EdgeInsets.only(right: right, left: left, bottom: 5.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            margin: const EdgeInsets.only(top: 5.0),
            child: TextFormField(
              controller: ctl,
              style: GoogleFonts.montserrat(fontSize: 14.0, color: Colors.grey),
              decoration: InputDecoration(
                filled: false,
                hintText: hintText,
                hintStyle:
                    GoogleFonts.montserrat(fontSize: 14.0, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color(0xFF1B6DF9).withOpacity(.2)),
                ),
              ),
              keyboardType: input,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );

Widget CustomDatePicker(label, {right = 20.0, left = 20.0, cB, border}) =>
    Padding(
      padding: EdgeInsets.only(right: right, left: left, bottom: 5.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => cB(),
            child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: border),
                margin: const EdgeInsets.only(top: 5.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.9, vertical: 5.0),
                      child: Text(label,
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0, color: Colors.grey)),
                    ))),
          ),
        ],
      ),
    );

Widget CustomMessage(ctx, {read = false, ctl, onSend}) => Container(
      width: MediaQuery.of(ctx).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: IconButton(
            icon: Icon(Icons.call),
            color: DEFAULT_COLOR,
            onPressed: !read ? () {} : null,
          ),
        ),
        Expanded(
            child: TextFormField(
          controller: ctl,
          style: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.grey),
          decoration: InputDecoration(
            filled: false,
            hintText: 'start messaging',
            hintStyle:
                GoogleFonts.montserrat(fontSize: 14.0, color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.text,
          readOnly: read,
          onSaved: (value) {},
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.send),
                  color: DEFAULT_COLOR,
                  onPressed: () => onSend()),
              IconButton(
                icon: Icon(Icons.attachment),
                color: DEFAULT_COLOR,
                onPressed: !read ? () {} : null,
              ),
            ],
          ),
        ),
      ]),
    );

Widget CustomMessageHeader(context, InboxModel model) => Row(
      children: [
        Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: DEFAULT_COLOR,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('${model.senderDp}'),
                  radius: 20,
                  backgroundColor: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${model.name}',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center),
                      Text('Online',
                          style: GoogleFonts.montserrat(
                              fontSize: 11, color: Colors.grey),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: IconButton(
            icon: Icon(null),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ],
    );

Widget CustomDropDownLanguage(List<String> list, label, text, callBack) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
              onChanged: (s) => callBack(s),
              name: 'skill',
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                labelText: label,
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
              hint: Text('$text'),
              items: list
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
