import 'dart:io';
import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/phoenix/screens/interviewProfile.dart';
import 'package:worka/employer_page/phoenix/screens/shortlist_employ.dart';
import 'package:worka/models/JobAppModel.dart';
import 'package:worka/models/MyPosted.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/dashboard_work/Success.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:http/http.dart' as http;

import 'createInterview.dart';

class Applications extends StatefulWidget {
  final String id;
  final String name;
  final MyPosted? extra;
  const Applications(this.id, this.name, {Key? key, this.extra})
      : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  bool isLoading = false;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<String> myShortList = [];
  late JobAppModel jobAppList;
  bool isSelected = false;

  @override
  void initState() {
    context.read<EmpController>().jobApplicationList(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text('Applications',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Color(0xff0D30D9),
                  onPressed: null,
                ),
              ),
            ]),
            const SizedBox(height: 8.0),
            Expanded(
                child: FutureBuilder(
              future: _fetchData(widget.id, context),
              builder: (ctx, snapshot) => _container(snapshot),
            )),
            const SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: DEFAULT_COLOR))
                  : myShortList.isNotEmpty
                      ? GeneralButtonContainer(
                          name: myShortList.isEmpty
                              ? 'Create ShortList'
                              : 'Create ShortList ${myShortList.length}',
                          color: Color(0xff0D30D9),
                          textColor: Colors.white,
                          onPress: () {
                            if (myShortList.length > jobAppList.maxChoices!) {
                              CustomSnack('Error',
                                  'Can\'t select more than ${jobAppList.maxChoices}');
                              return;
                            }
                            selectPage(context, () {
                              executeData(myShortList, context, widget.id);
                            }, () {
                              Get.to(() =>
                                  ShortList_Employment(myShortList, widget.id));
                            });
                          },
                          paddingBottom: 3,
                          paddingLeft: 10,
                          paddingRight: 10,
                          paddingTop: 5,
                        )
                      : Container(),
            )
          ],
        ),
      ),
    ));
  }

  void executeData(itemList, BuildContext c, String id) async {
    setState(() {
      isLoading = true;
    });
    if (myShortList.isNotEmpty) {
      createShortList(c, id, myShortList.join(','));
    } else {
      setState(() {
        isLoading = false;
      });
      CustomSnack('Error', 'Select An Employee for ShortListing....');
    }
  }

  createShortList(BuildContext c, String id, String data) async {
    try {
      final res = await http.Client()
          .post(Uri.parse('${ROOT}create_shortlist/$id'), headers: {
        'Accept': '*/*',
        'Authorization': 'TOKEN ${c.read<Controller>().token}'
      }, body: {
        'shortlist_id': "$data"
      });
      if (res.statusCode == 200) {
        Get.to(() => Success(
              'ShortList created successfully',
              imageAsset: 'assets/succ.png',
              callBack: () => Get.off(() => CreateInterview(widget.id)),
            ));
      }
    } on SocketException {
      CustomSnack('Error', 'check internet Connection ....');
    } on Exception {
      CustomSnack('Error', 'unable to create ShortList, please try again');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getItems(itemList) {
    return itemList
        .where((element) => element.ischecked == true)
        .map((e) => e.uid)
        .toList()
        .join(',')
        .toString();
  }

  Widget listItem(BuildContext context, Application j, i) => InkWell(
        onTap: () => Get.to(() =>
            InterviewProfile(j.applicant!.uid!, j.applicant!.displayPicture!)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color:
                        j.isNew == true ? DEFAULT_COLOR : Colors.transparent),
                color: Colors.white,
                boxShadow: [
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                            radius: 17,
                            backgroundImage:
                                NetworkImage('${j.applicant!.displayPicture}'),
                            backgroundColor: Colors.blue),
                      ),
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text:
                                '${j.applicant!.firstName} ${j.applicant!.lastName} ${j.applicant!.otherName} '
                                    .toUpperCase(),
                            style: GoogleFonts.montserrat(
                                color: DEFAULT_COLOR.withOpacity(.5)),
                            children: [
                              TextSpan(
                                  text: 'applied to your Job posting ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13, color: Colors.grey)),
                              TextSpan(
                                  text: '${widget.name} ',
                                  style: GoogleFonts.montserrat(
                                      color: DEFAULT_COLOR.withOpacity(.5))),
                              TextSpan(
                                  text: 'in ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13, color: Colors.grey)),
                              TextSpan(
                                  text: '${j.applicant!.location}.',
                                  style: GoogleFonts.montserrat(
                                      color: DEFAULT_COLOR.withOpacity(.5))),
                            ],
                          ),
                          minFontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ),
                      Container()
                    ]),
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          '${j.applicant!.gender}'.toUpperCase(),
                          minFontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 7.0),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.3),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (j.applicant!.ischecked == true) {
                                  int index = myShortList.indexWhere(
                                      (element) => element == j.applicant!.uid);
                                  setState(() {
                                    myShortList.removeAt(index);
                                    j.applicant!.ischecked = false;
                                  });
                                }
                              },
                              child: Text('Decline',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.red)),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              setState(() {
                                j.applicant!.ischecked = true;
                                myShortList.add(j.applicant!.uid!);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 7.0),
                              decoration: BoxDecoration(
                                color: j.applicant!.ischecked == true
                                    ? Colors.green.shade300
                                    : DEFAULT_COLOR,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Text('Accept',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    ]),
              ],
            )),
      );

  _fetchData(id, BuildContext context) {
    return this._memoizer.runOnce(() async {
      return await jobApplicationList(context, id);
    });
  }

  Widget _container(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        List<Application>? j = snapshot.data!.applications;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    value: isSelected || myShortList.isNotEmpty,
                    onChanged: (b) {
                      List<Application> data =
                          getAllList(snapshot.data!.applications, b);
                      if (b!) {
                        List c = getIds(data);
                        setState(() {
                          myShortList.clear();
                          myShortList.addAll(c.cast<String>());
                        });
                      } else {
                        setState(() {
                          myShortList.clear();
                        });
                      }

                      setState(() {
                        isSelected = b;
                        j!.clear();
                        j.addAll(data);
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(isSelected ? 'Deselect all' : 'Select all',
                      style: GoogleFonts.montserrat(color: DEFAULT_COLOR)),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: j!.length,
                    itemBuilder: (ctx, i) => listItem(ctx, j[i], i)))
          ],
        );
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  getAllList(applications, bool? b) {
    return applications
        .map<Application>((Application e) => Application(
            applicant: Applicant(
                uid: e.applicant!.uid,
                firstName: e.applicant!.firstName,
                lastName: e.applicant!.lastName,
                otherName: e.applicant!.otherName,
                location: e.applicant!.location,
                about: e.applicant!.about,
                gender: e.applicant!.gender,
                ischecked: b,
                displayPicture: e.applicant!.displayPicture),
            isNew: e.isNew))
        .toList();
  }

  getIds(List<Application> data) {
    return data.map((e) => e.applicant!.uid).toList();
  }

  Future<JobAppModel> jobApplicationList(BuildContext c, id) async {
    try {
      final res = await Dio().get('${ROOT}job_application_list/$id',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        this.jobAppList = JobAppModel.fromJson(res.data);
        return this.jobAppList;
      }
    } on SocketException {
      CustomSnack('Error', 'Check Internet Connection..');
    } on Exception {
      CustomSnack('Error', 'Could not submit job. Please try again');
    }
    return this.jobAppList;
  }
}
