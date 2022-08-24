import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/phoenix/model/AlertNotification.dart';

class EmployerAlertPage extends StatefulWidget {
  @override
  State<EmployerAlertPage> createState() => _EmployerAlertPageState();
}

class _EmployerAlertPageState extends State<EmployerAlertPage> {
  final c = RefreshController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: c,
            onRefresh: () => context
                .read<EmpController>()
                .fetchNotifications(context, ctl: c),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Center(
                            child: AutoSizeText('Alert',
                                minFontSize: 12,
                                maxFontSize: 18,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, color: Color(0xff0D30D9)),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ]),
                  SizedBox(height: 25.0),
                  Expanded(
                    child: context.watch<EmpController>().alertList.length > 0
                        ? SingleChildScrollView(
                            child: Column(
                            children: [
                              ...List.generate(
                                  context
                                      .watch<EmpController>()
                                      .alertList
                                      .length,
                                  (index) => listItem(
                                      context,
                                      context
                                          .watch<EmpController>()
                                          .alertList[index]))
                            ],
                          ))
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, AlertNotification alert) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
            left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(.2),
                    radius: 17,
                    child: Icon(Icons.message, color: Colors.white, size: 18)),
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('${alert.message?.trim()}',
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.0,
            ),
            Text('${DateFormat('yyyy-MM-dd hh:mm a').format(alert.created)}',
                style: GoogleFonts.lato(color: Colors.grey, fontSize: 12))
          ],
        ),
      );
}
