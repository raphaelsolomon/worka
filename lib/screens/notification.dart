import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../phoenix/Controller.dart';
import '../phoenix/CustomScreens.dart';
import '../phoenix/model/Constant.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final controller = RefreshController();

  @override
  void initState() {
    context.read<Controller>().fetchNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SmartRefresher(
          onRefresh: () =>
              context.read<Controller>().fetchNotifications(ctl: controller),
          controller: controller,
          child: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace),
                          color: DEFAULT_COLOR,
                          onPressed: () => Get.back(),
                        ),
                      ),
                      Text('Notification Settings',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, color: DEFAULT_COLOR),
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
                SizedBox(height: 20.0),
                context.watch<Controller>().notificationModel != null
                    ? Expanded(
                        child: Column(children: [
                          items(
                              context,
                              context
                                  .watch<Controller>()
                                  .notificationModel!
                                  .email!,
                              'email notifications', (b) async {
                            bool value = await execute(
                                context, 'email', b);
                            setState(() {
                              context
                                  .read<Controller>()
                                  .notificationModel!
                                  .setEmail(value);
                            });
                          }),
                          SizedBox(
                            height: 15.0,
                          ),
                          items(
                              context,
                              context
                                  .watch<Controller>()
                                  .notificationModel!
                                  .login!,
                              'receive notification when you login on new device',
                              (b) async {
                            bool value = await execute(context, 'login', b);
                            setState(() {
                              context
                                  .read<Controller>()
                                  .notificationModel!
                                  .setLogin(value);
                            });
                          }),
                          SizedBox(
                            height: 15.0,
                          ),
                          items(
                              context,
                              context
                                  .watch<Controller>()
                                  .notificationModel!
                                  .newsletter!,
                              'receive newsletter', (b) async {
                            bool value =
                                await execute(context, 'newsletter', b);
                            setState(() {
                              context
                                  .read<Controller>()
                                  .notificationModel!
                                  .setNewsLetter(value);
                            });
                          }),
                          SizedBox(
                            height: 15.0,
                          ),
                          items(
                              context,
                              context
                                  .watch<Controller>()
                                  .notificationModel!
                                  .update!,
                              'recieve email about our update', (b) async {
                            bool value = await execute(context, 'update', b);
                            setState(() {
                              context
                                  .read<Controller>()
                                  .notificationModel!
                                  .setUpdate(value);
                            });
                          }),
                          SizedBox(
                            height: 15.0,
                          ),
                        ]),
                      )
                    : Expanded(
                        child: Center(child: CircularProgressIndicator()))
              ],
            ),
          ),
        ));
  }

  Widget items(context, bool value, text, Function cB) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('$text'.capitalizeFirst!,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.black87)),
            ),
            Switch(
                value: value,
                onChanged: (b) {
                  cB(b);
                })
          ],
        ),
      );

  Future<bool> execute(BuildContext c, url, bool b) async {
    String value = b ? 'on' : 'off';
    bool returnValue = !b;
    try {
      final res = await Dio().get('${ROOT}set_${url}_notify/$value',
          options: Options(headers: {
            'Authorization': 'TOKEN ${c.read<Controller>().token}'
          }));
      if (res.statusCode == 200) {
        print(res.data);
        returnValue = b;
      }
    } on SocketException {
      CustomSnack('Error', 'check internet connection');
    } on Exception {
      CustomSnack('Error', 'unable to fetch notifications');
    }
    return returnValue;
  }
}
