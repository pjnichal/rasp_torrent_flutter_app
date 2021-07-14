import 'dart:convert';

TorrentMessage torrentMessageFromJson(String str) =>
    TorrentMessage.fromJson(json.decode(str));

String torrentMessageToJson(TorrentMessage data) => json.encode(data.toJson());

class TorrentMessage {
  TorrentMessage({
    required this.message,
  });

  String message;

  factory TorrentMessage.fromJson(Map<String, dynamic> json) => TorrentMessage(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
