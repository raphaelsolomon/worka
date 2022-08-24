import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/phoenix/screens/shortlist_final.dart';
import 'package:worka/models/SubmittedInterview.dart';

import '../../../phoenix/CustomScreens.dart';
import '../../../phoenix/GeneralButtonContainer.dart';
import '../../../phoenix/model/Constant.dart';
import 'ViewEmpInterview.dart';

class ViewSubmitted extends StatefulWidget {
  final String id;
  const ViewSubmitted(this.id, {Key? key}) : super(key: key);

  @override
  State<ViewSubmitted> createState() => _ViewSubmittedState();
}

class _ViewSubmittedState extends State<ViewSubmitted> {
  bool isLoading = false;
  List<String> myShortList = [];
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //custom app design
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            color: Color(0xff0D30D9),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Flexible(
                          child: Text('Submitted Interview',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, color: Color(0xff0D30D9)),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: IconButton(
                            icon: Icon(null),
                            color: Color(0xff0D30D9),
                            onPressed: null,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: _fetchData(),
                    builder: (ctx, snapshot) => _container(snapshot, widget.id),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: DEFAULT_COLOR))
                          : myShortList.isNotEmpty
                              ? GeneralButtonContainer(
                                  name: myShortList.isEmpty
                                      ? 'Create ShortList'
                                      : 'Create ShortList ${myShortList.length}',
                                  color: Color(0xff0D30D9),
                                  textColor: Colors.white,
                                  onPress: () {
                                    if (myShortList.isEmpty) {
                                      CustomSnack(
                                          'Error', 'No Employee Selected');
                                      return;
                                    }

                                    Get.to(() => ShortlistFinal(
                                        widget.id, myShortList.join(',')));
                                  },
                                  paddingBottom: 3,
                                  paddingLeft: 10,
                                  paddingRight: 10,
                                  paddingTop: 5,
                                )
                              : Container())
                ])));
  }

  _fetchData() async {
    return this._memoizer.runOnce(() async {
      return await context
          .read<EmpController>()
          .viewSubmittedInterview(context, widget.id);
    });
  }

  Widget _container(snapshot, id) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        List<Submission> items = snapshot.data.submission;
        if (items.isNotEmpty) {
          return Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                        value: isSelected || myShortList.isNotEmpty,
                        onChanged: (b) {
                          List<Submission> data = getAllList(snapshot.data.submission, b);
                          if (b!) {
                            List c = getIds(data);
                            myShortList.clear();
                            setState(() {
                              myShortList.addAll(c.cast<String>());
                            });
                          } else {
                            setState(() {
                              myShortList.clear();
                            });
                          }

                          setState(() {
                            isSelected = b;
                            items.clear();
                            items.addAll(data);
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
                      itemCount: items.length,
                      itemBuilder: (ctx, i) => listItem(ctx, items[i], id)),
                ),
              ],
            ),
          );
        } else {
          return Expanded(
            child: Center(
                child: Text('No Submission Yet',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)))),
          );
        }
      } else {
        return Expanded(
          child: Center(
              child: Text('No Submission Yet',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: Color(0xff0D30D9)))),
        );
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Widget listItem(BuildContext context, Submission s, String id) => InkWell(
        onTap: () => Get.to(() => ViewEmpInterview(id, s.uid!)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
          margin: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.06),
                offset: Offset.zero,
                blurRadius: 3,
                spreadRadius: 3),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      backgroundColor: DEFAULT_COLOR,
                      radius: 17,
                      child: Icon(Icons.save, color: Colors.white, size: 18)),
                  Flexible(
                    flex: 9,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText('${s.firstName} ${s.lastName}',
                              minFontSize: 13,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 18,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text('${s.location}',
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey, fontSize: 13)),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text('Submitted',
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey, fontSize: 13))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (s.ischecked == true) {
                        setState(() {
                          s.ischecked = false;
                          var i = myShortList
                              .indexWhere((element) => element == s.uid);
                          myShortList.removeAt(i);
                        });
                      } else {
                        setState(() {
                          s.ischecked = true;
                          myShortList.add(s.uid!);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 7.0),
                      decoration: BoxDecoration(
                        color: s.ischecked == true
                            ? Colors.green.shade300
                            : DEFAULT_COLOR,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Text(s.ischecked == true ? 'Decline' : 'Accept',
                          style: GoogleFonts.montserrat(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      );

  getIds(j) {
    return j.map((e) => e.uid).toList();
  }

  getAllList(j, b) {
    return j
        .map<Submission>((e) => Submission(
            uid: e.uid,
            firstName: e.firstName,
            lastName: e.lastName,
            location: e.location,
            ischecked: b))
        .toList();
  }
}
