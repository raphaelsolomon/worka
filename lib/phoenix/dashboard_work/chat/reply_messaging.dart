import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worka/models/InboxModel.dart';
import 'package:worka/models/MessageModel.dart';
import 'package:worka/phoenix/Resusable.dart';
import '../../Controller.dart';
import '../../GeneralButtonContainer.dart';

class ReplyMessaging extends StatefulWidget {
  final InboxModel inboxModel;
  ReplyMessaging(this.inboxModel, {Key? key}) : super(key: key);

  @override
  _ReplyMessagingState createState() => _ReplyMessagingState();
}

class _ReplyMessagingState extends State<ReplyMessaging> {
  final _controller = TextEditingController();
  static const COMMAND = "preloaded_messages";
  late WebSocketChannel _channel;
  MessageModel model = MessageModel(command: '', messages: []);

  @override
  void initState() {
    _channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://chat.workanetworks.com/ws/chat/${widget.inboxModel.chatUid}/'),
    );
    _channel.sink.add(jsonEncode({
      'room_name': '${widget.inboxModel.chatUid}',
      'command': 'preload_message'
    }));
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 5.0),
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
                  Expanded(
                      child: Container(
                    color: Colors.transparent,
                    child: StreamBuilder(
                      stream: _channel.stream,
                      builder: (context, AsyncSnapshot s) {
                        if (s.data != null) {
                          if (jsonDecode(s.data)['command'] == COMMAND) {
                            return showPreload(s.data);
                          } else {
                            return showNewMsg(s.data);
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )),
                  CustomMessage(context,
                      ctl: _controller,
                      read: false,
                      onSend: () => sendMessage())
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  Widget _listSenderItem(Messages message) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 60.0, top: 5.0, right: 10.0, bottom: 5.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.blue),
            child: AutoSizeText('${message.message}',
                maxLines: 1000,
                minFontSize: 11,
                maxFontSize: 20,
                style:
                    GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
          ),
        ],
      );

  Widget _listReceiverItem(Messages message) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          message.message != 'interview'
              ? Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, top: 5.0, right: 60.0, bottom: 5.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue),
                  child: AutoSizeText('${message.message}',
                      minFontSize: 11,
                      maxFontSize: 20,
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.white)),
                )
              : Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: GeneralButtonContainer(
                      name: 'Start Interview',
                      color: Color(0xff0D30D9),
                      textColor: Colors.white,
                      onPress: () {},
                      paddingBottom: 3,
                      paddingLeft: 30,
                      paddingRight: 30,
                      paddingTop: 5,
                      radius: 9.0,
                    ),
                  ))
        ],
      );

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      var message = jsonEncode({
        'message': '${_controller.text.trim()}',
        'chatid': '${widget.inboxModel.chatUid}',
        'sender': '${context.read<Controller>().email}',
        'command': 'new_message'
      });
      _channel.sink.add(message);
    }
    _channel.sink.add(jsonEncode({
      'room_name': '${widget.inboxModel.chatUid}',
      'command': 'preload_message'
    }));
    _controller.clear();
    //print(context.read<Controller>().email);
  }

  void filePicker() async {}

  showPreload(data) {
    model = MessageModel.fromJson(jsonDecode(data));
    return ListView.builder(
        itemCount: model.messages.length,
        shrinkWrap: true,
        reverse: false,
        primary: true,
        itemBuilder: (ctx, i) {
          return model.messages[i].sender == 'admin'
              ? _listReceiverItem(model.messages.toList()[i])
              : _listSenderItem(model.messages.toList()[i]);
        });
  }

  showNewMsg(data) {
    model.messages.add(Messages.fromJson(jsonDecode(data)));
    return ListView.builder(
        itemCount: model.messages.length,
        reverse: false,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (ctx, i) {
          print(model.messages[i].sender);
          return model.messages[i].sender == 'admin'
              ? _listReceiverItem(model.messages.toList()[i])
              : _listSenderItem(model.messages.toList()[i]);
        });
  }
}
