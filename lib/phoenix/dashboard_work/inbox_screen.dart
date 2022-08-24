import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/model/Constant.dart';
import '../../models/InboxModel.dart';
import '../Controller.dart';
import 'package:get/get.dart';
import 'chat/no_reply_messaging.dart';
import 'chat/reply_messaging.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  AsyncMemoizer asyncMemoizer = new AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Center(
                    child: AutoSizeText('Inbox',
                        minFontSize: 12,
                        maxFontSize: 20,
                        style: GoogleFonts.montserrat(
                            fontSize: 20, color: DEFAULT_COLOR),
                        textAlign: TextAlign.center),
                  ),
                ),
              ]),
              SizedBox(height: 20.0),
              FutureBuilder(
                  future: fetchData(),
                  builder: (ctx, snapshot) => _container(snapshot))
            ],
          ),
        ),
      ),
    );
  }

  fetchData() {
    return asyncMemoizer.runOnce(() async {
      return await context.read<Controller>().getInbox();
    });
  }

  Widget _container(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Expanded(child: Center(child: const Text('Error')));
      } else if (snapshot.hasData) {
        List<InboxModel> inboxList = snapshot.data;
        return Expanded(
            child: ListView.builder(
                itemCount: inboxList.length,
                itemBuilder: (ctx, i) => _listItem(inboxList, i)));
      } else {
        return Expanded(child: Center(child: const Text('Empty data')));
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }

  Widget _listItem(List<InboxModel> inboxList, int i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.1),
                offset: Offset.zero,
                spreadRadius: 2,
                blurRadius: 10)
          ],
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            if (context.read<Controller>().inboxList[i].chatType ==
                'no_reply') {
              Get.to(() =>
                  NoReplyMessaging(context.read<Controller>().inboxList[i], i));
            } else {
              Get.to(() =>
                  ReplyMessaging(context.read<Controller>().inboxList[i]));
            }
          },
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(width: 10.0),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${context.watch<Controller>().inboxList[i].senderDp}'),
                      radius: 20,
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                    '${context.watch<Controller>().inboxList[i].name}',
                                    minFontSize: 11,
                                    maxFontSize: 17,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: AutoSizeText(
                                      context
                                                  .watch<Controller>()
                                                  .inboxList[i]
                                                  .chatChannel!
                                                  .length >
                                              0
                                          ? '${DateFormat('yyyy-MM-dd hh:mm a').format(context.watch<Controller>().inboxList[i].chatChannel!.last.created)}'
                                          : '${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now())}',
                                      minFontSize: 11,
                                      maxFontSize: 17,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal)),
                                )
                              ]),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              AutoSizeText('Online',
                                  minFontSize: 11,
                                  maxFontSize: 17,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 5.0),
                              Icon(Icons.panorama_fisheye_outlined,
                                  color: context
                                              .watch<Controller>()
                                              .inboxList[i]
                                              .name ==
                                          'Worka Admin'
                                      ? Colors.greenAccent
                                      : Color(0xff0D30D9),
                                  size: 8),
                            ],
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: AutoSizeText(
                                context
                                            .watch<Controller>()
                                            .inboxList[i]
                                            .chatChannel!
                                            .length >
                                        0
                                    ? '${context.watch<Controller>().inboxList[i].chatChannel!.last.message}'
                                    : 'open to chat',
                                minFontSize: 13,
                                maxFontSize: 17,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      );
}
