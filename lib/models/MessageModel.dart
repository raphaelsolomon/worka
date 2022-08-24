class MessageModel {
  MessageModel({
    required this.command,
    required this.messages,
  });
  late final String command;
  late final List<Messages> messages;

  MessageModel.fromJson(Map<String, dynamic> json) {
    command = json['command'];
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['command'] = command;
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Messages {
  Messages({
    required this.sender,
    required this.command,
    required this.message,
    required this.timestamp,
  });
  late final String sender;
  late final String command;
  late final String message;
  late final String timestamp;

  Messages.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    command = json['command'];
    message = json['message'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender;
    _data['command'] = command;
    _data['message'] = message;
    _data['timestamp'] = timestamp;
    return _data;
  }
}
