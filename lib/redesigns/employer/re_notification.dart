import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/phoenix/model/AlertNotification.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/redesigns/drawer/re_drawer.dart';

class ReNotification extends StatefulWidget {
  const ReNotification({super.key});

  @override
  State<ReNotification> createState() => _ReNotificationState();
}

class _ReNotificationState extends State<ReNotification> {
  final notificationController = RefreshController();
  final scaffold = GlobalKey<ScaffoldState>();
  bool isNotification = true;
  bool isNotificationLoading = true;

  List<AlertNotification> alertList = [];

  @override
  void initState() {
    context
        .read<EmpController>()
        .fetchNotifications(context, notificationController)
        .then((value) {
      setState(() {
        alertList = value;
        isNotificationLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      drawer: ReDrawer(scaffold),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => scaffold.currentState!.openDrawer(),
                      child: Icon(
                        Icons.menu,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Notifications',
                      style: GoogleFonts.lato(
                          fontSize: 17.0, color: Colors.black54))
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                      child: GestureDetector(
                    onTap: () => setState(() => isNotification = true),
                    child: Column(
                      children: [
                        Text(
                          'All Notifications',
                          style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: isNotification
                                  ? DEFAULT_COLOR
                                  : Colors.black54),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Divider(
                            thickness: isNotification ? 5.0 : 2.0,
                            color:
                                isNotification ? DEFAULT_COLOR : Colors.black26,
                          ),
                        )
                      ],
                    ),
                  )),
                  Flexible(
                      child: GestureDetector(
                    onTap: () => setState(() => isNotification = false),
                    child: Column(
                      children: [
                        Text(
                          'Applications',
                          style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: !isNotification
                                  ? DEFAULT_COLOR
                                  : Colors.black54),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          thickness: !isNotification ? 5.0 : 2.0,
                          color:
                              !isNotification ? DEFAULT_COLOR : Colors.black26,
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            isNotification
                ? getNotifications(notificationController, context)
                : getApplication(notificationController, context)
          ],
        ),
      ),
    );
  }

  Widget getNotifications(controller, BuildContext context) => Expanded(
        child: SmartRefresher(
          header: WaterDropHeader(),
          controller: controller,
          onRefresh: () => context
              .read<EmpController>()
              .fetchNotifications(context, controller),
          child: Container(
              child: isNotificationLoading
                  ? Center(
                      child: CircularProgressIndicator(color: DEFAULT_COLOR),
                    )
                  : alertList.isEmpty
                      ? Center(child: _isEmpty(isNotification))
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            ...List.generate(
                                alertList
                                    .where((element) =>
                                        element.nType == 'notification')
                                    .toList()
                                    .length,
                                (i) => listItem(
                                    context,
                                    alertList
                                        .where((element) =>
                                            element.nType == 'notification')
                                        .toList()[i]))
                          ],
                        ))),
        ),
      );

  Widget getApplication(controller, BuildContext context) => Expanded(
        child: SmartRefresher(
          header: WaterDropHeader(),
          controller: controller,
          onRefresh: () => context
              .read<EmpController>()
              .fetchNotifications(context, controller),
          child: Container(
              child: isNotificationLoading
                  ? Center(
                      child: CircularProgressIndicator(color: DEFAULT_COLOR),
                    )
                  : alertList.isEmpty
                      ? Center(child: _isEmpty(isNotification))
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            ...List.generate(
                                alertList
                                    .where((element) =>
                                        element.nType == 'application')
                                    .toList()
                                    .length,
                                (i) => listItem(
                                    context,
                                    alertList
                                        .where((element) =>
                                            element.nType == 'application')
                                        .toList()[i]))
                          ],
                        ))),
        ),
      );
}

Widget listItem(BuildContext context, AlertNotification alert) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
          left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: DEFAULT_COLOR.withOpacity(.05),
                offset: Offset.zero,
                blurRadius: 3,
                spreadRadius: 5),
            BoxShadow(
                color: DEFAULT_COLOR.withOpacity(.05),
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
                  backgroundColor: DEFAULT_COLOR,
                  radius: 17,
                  child: Icon(Icons.message, color: Colors.white, size: 18)),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('${alert.message?.trim()}',
                      maxLines: 2,
                      style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: 14.0
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text('${DateFormat('yyyy-MM-dd hh:mm a').format(alert.created)}',
              style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0))
        ],
      ),
    );

Widget _isEmpty(b) => Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text('Empty State',
              style: GoogleFonts.lato(fontSize: 19.0, color: Colors.black54)),
          const SizedBox(height: 20.0),
          Text('You don\'t have any ${b ? 'Notification' : 'Applicant'} yet.',
              style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54)),
        ]));


// Column(children: [
//                           const SizedBox(
//                             height: 10.0,
//                           ),
//                           _isEmpty(isNotification),
//                           const SizedBox(height: 40.0),
//                         ])