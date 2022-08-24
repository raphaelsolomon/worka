import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/models/InboxModel.dart' as InboxModel;
import 'package:worka/phoenix/Resusable.dart';
import 'package:worka/phoenix/dashboard_work/interview/interviewWelcome.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/phoenix/model/noreply_data.dart';

import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';

class NoReplyMessaging extends StatefulWidget {
  final InboxModel.InboxModel inboxModel;
  final int index;
  NoReplyMessaging(this.inboxModel, this.index, {Key? key}) : super(key: key);

  @override
  State<NoReplyMessaging> createState() => _NoReplyMessagingState();
}

class _NoReplyMessagingState extends State<NoReplyMessaging> {
  final _refreshController = RefreshController();

 @override
initState() {
   context.read<Controller>().getNoReplyMessage(widget.inboxModel.chatUid, _refreshController);
   super.initState();
 }  

  @override
  Widget build(BuildContext context) {
    var item = context.watch<Controller>().noreply;
    print(widget.inboxModel.chatUid);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () => context
                .read<Controller>()
                .getNoReplyMessage(widget.inboxModel.chatUid, _refreshController),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Column(
                        children: [
                          CustomMessageHeader(context, widget.inboxModel),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(.1),
                                  offset: Offset.zero,
                                  blurRadius: 15,
                                  spreadRadius: 10),
                            ]),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Expanded(
                            child: item == null
                                ? Container(
                                    child: Center(
                                    child: CircularProgressIndicator(color: DEFAULT_COLOR),
                                  ))
                                : ListView.builder(
                                    itemCount: item.chatChannel.length,
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) => _listReceiverItem(
                                        item.chatChannel, widget.index, i, width))),
                        CustomMessage(context, read: true)
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _listReceiverItem(List<ChatChannel> itemData, index, i, width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemData[i].messageType == 'text'
            ? Container(
                margin: const EdgeInsets.only(
                    left: 10.0, top: 5.0, right: 60.0, bottom: 5.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue),
                child: AutoSizeText('${itemData[i].message}',
                    minFontSize: 11,
                    maxFontSize: 20,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Colors.white)),
              )
            : Visibility(
                visible: true,
                child: Container(
                  width: width,
                  child: GeneralButtonContainer(
                    name: 'Start Interview',
                    color: Color(0xff0D30D9),
                    textColor: Colors.white,
                    onPress: () {
                      if (itemData[i].messageType == 'objective_interview') {
                        Get.to(() => InterviewWelcome(
                            false, itemData[i].message.trim()));
                      } else {
                        Get.to(() =>
                            InterviewWelcome(true, itemData[i].message.trim()));
                      }
                    },
                    paddingBottom: 3,
                    paddingLeft: 30,
                    paddingRight: 30,
                    paddingTop: 5,
                    radius: 9.0,
                  ),
                ))
      ],
    );
  }
}
