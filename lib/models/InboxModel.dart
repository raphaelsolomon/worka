// To parse this JSON data, do
//
//     final inboxModel = inboxModelFromJson(jsonString);

import 'dart:convert';

List<InboxModel> inboxModelFromJson(String str) =>
    List<InboxModel>.from(json.decode(str).map((x) => InboxModel.fromJson(x)));

String inboxModelToJson(List<InboxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InboxModel {
  InboxModel({
    this.name,
    this.senderDp,
    this.chatType,
    this.chatUid,
    this.chatChannel,
  });

  String? name;
  String? senderDp;
  String? chatType;
  String? chatUid;
  List<ChatChannel>? chatChannel;

  @override
  String toString() {
    return 'InboxModel{name: $name, senderDp: $senderDp, chatType: $chatType, chatUid: $chatUid, chatChannel: $chatChannel}';
  }

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        name: json["name"],
        senderDp: json["sender_dp"],
        chatType: json["chat_type"],
        chatUid: json["chat_uid"],
        chatChannel: List<ChatChannel>.from(
            json["chat_channel"].map((x) => ChatChannel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sender_dp": senderDp,
        "chat_type": chatType,
        "chat_uid": chatUid,
        "chat_channel": List<dynamic>.from(chatChannel!.map((x) => x.toJson())),
      };
}

class ChatChannel {
  ChatChannel({
    this.message,
    this.message_type,
    required this.created,
  });

  @override
  String toString() {
    return 'ChatChannel{message: $message, message_type: $message_type, created: $created}';
  }

  String? message;
  String? message_type;
  DateTime created;

  factory ChatChannel.fromJson(Map<String, dynamic> json) => ChatChannel(
        message: json["message"],
        message_type: json["message_type"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "created": created.toIso8601String(),
      };
}
