// To parse this JSON data, do
//
//     final noReplyData = noReplyDataFromMap(jsonString);

import 'dart:convert';

NoReplyData noReplyDataFromMap(String str) => NoReplyData.fromMap(json.decode(str));

String noReplyDataToMap(NoReplyData data) => json.encode(data.toMap());

class NoReplyData {
    NoReplyData({
        required this.chatChannel,
        required this.senderDp,
        required this.name,
    });

    List<ChatChannel> chatChannel;
    String senderDp;
    String name;

    factory NoReplyData.fromMap(Map<String, dynamic> json) => NoReplyData(
        chatChannel: List<ChatChannel>.from(json["chat_channel"].map((x) => ChatChannel.fromMap(x))),
        senderDp: json["sender_dp"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "chat_channel": List<dynamic>.from(chatChannel.map((x) => x.toMap())),
        "sender_dp": senderDp,
        "name": name,
    };
}

class ChatChannel {
    ChatChannel({
        required this.message,
        required this.messageType,
        required this.created,
    });

    String message;
    String messageType;
    DateTime created;

    factory ChatChannel.fromMap(Map<String, dynamic> json) => ChatChannel(
        message: json["message"],
        messageType: json["message_type"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "message_type": messageType,
        "created": created.toIso8601String(),
    };
}
