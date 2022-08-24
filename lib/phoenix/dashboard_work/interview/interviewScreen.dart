import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/models/InterviewAllModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';

import '../../CustomScreens.dart';
import 'interviewWelcome.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  final controller = RefreshController();
  List<InterviewAllModel> allModel = [];

  Future<List<InterviewAllModel>> execute() async {
    final res = await http.Client().get(Uri.parse('${ROOT}get_my_interview/'),
        headers: {
          'Authorization': 'TOKEN ${context.read<Controller>().token}'
        }).timeout(Duration(seconds: 10));
    if (res.statusCode == 200) {
      final parsed = jsonDecode(res.body);
      allModel = parsed
          .map<InterviewAllModel>((json) => InterviewAllModel.fromJson(json))
          .toList();
    }
    return allModel;
  }

  Widget _container(AsyncSnapshot<List<InterviewAllModel>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Expanded(
            child: Center(
                child: Text('Error',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center)));
      } else if (snapshot.hasData) {
        if (snapshot.data!.isEmpty) {
          return Expanded(
              child: Center(
                  child: Text('No Interview yet',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Color(0xff0D30D9)),
                      textAlign: TextAlign.center)));
        }
        return Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (ctx, i) => InkWell(
            onTap: () => onClick(snapshot.data![i]),
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 1, color: DEFAULT_COLOR.withOpacity(.1))),
                child: _listItem(snapshot.data![i])),
          ),
        ));
      } else {
        return Expanded(
            child: Center(
                child: Text('No Interview yet',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center)));
      }
    } else {
      return Expanded(
          child: Center(child: Text('State: ${snapshot.connectionState}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
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
                Text('My Interviews',
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
              FutureBuilder(
                  future: execute(),
                  builder:
                      (ctx, AsyncSnapshot<List<InterviewAllModel>> snapshot) =>
                          _container(snapshot))
            ],
          ),
        ));
  }

  onClick(InterviewAllModel item) {
    if (!checkDate(item)) {
      CustomSnack('Error', 'This Interview is not valid');
      return;
    }
    if (item.status != 'open') {
      CustomSnack('Error', 'This Interview is closed.');
      return;
    }
    Get.to(() =>
        InterviewWelcome(item.interviewType == 'theory', item.interviewUid));
  }

  Widget _listItem(InterviewAllModel allModel) => Column(
        children: [
          SizedBox(height: 12.0),
          Row(
            children: [
              SizedBox(width: 7.0),
              CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('${allModel.job!.employerLogo}'),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AutoSizeText('${allModel.title}',
                                minFontSize: 11,
                                maxFontSize: 17,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: AutoSizeText(
                                  'Exp. Date : ${DateFormat('MM/dd/yyyy').format(allModel.endDate)}',
                                  minFontSize: 11,
                                  maxFontSize: 17,
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal)),
                            ),
                          )
                        ]),
                    SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                                'Budget : ${allModel.job!.budget}',
                                minFontSize: 10,
                                maxFontSize: 17,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(width: 5.0),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: AutoSizeText.rich(
                                  TextSpan(text: 'Status : ', children: [
                                    TextSpan(
                                        text: checkDate(allModel)
                                            ? '${allModel.status}'
                                                .capitalizeFirst!
                                            : 'Expired'.capitalizeFirst!,
                                        style: GoogleFonts.montserrat(
                                            color: allModel.status == 'open' &&
                                                    checkDate(allModel)
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w500))
                                  ]),
                                  minFontSize: 10,
                                  maxFontSize: 17,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12.0),
        ],
      );

  checkDate(InterviewAllModel allModel) {
    if (DateTime.now().millisecondsSinceEpoch <
        allModel.endDate.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }
}
