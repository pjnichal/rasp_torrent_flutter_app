import 'dart:convert';

List<TorrentModel> torrentModelFromJson(String str) => List<TorrentModel>.from(
    json.decode(str).map((x) => TorrentModel.fromJson(x)));

String torrentModelToJson(List<TorrentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TorrentModel {
  TorrentModel({
    required this.id,
    required this.isDelete,
    required this.isDeleteWithData,
    required this.isPause,
    required this.leftUntilDone,
    required this.title,
    required this.progress,
    required this.rateDownloaded,
    required this.status,
    required this.totalSize,
    required this.firebaseId,
  });

  int id;
  bool isDelete;
  bool isDeleteWithData;
  int isPause;
  int leftUntilDone;
  String title;
  double progress;
  int rateDownloaded;
  String status;
  int totalSize;
  String firebaseId;

  factory TorrentModel.fromJson(Map<String, dynamic> json) => TorrentModel(
        id: json["id"],
        isDelete: json["isDelete"],
        isDeleteWithData: json["isDeleteWithData"],
        isPause: json["isPause"],
        leftUntilDone: json["left_until_done"],
        title: json["title"],
        progress: json["progress"].toDouble(),
        rateDownloaded: json["rate_downloaded"],
        status: json["status"],
        totalSize: json["total_size"],
        firebaseId: json["firebase_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDelete": isDelete,
        "isDeleteWithData": isDeleteWithData,
        "isPause": isPause,
        "left_until_done": leftUntilDone,
        "title": title,
        "progress": progress,
        "rate_downloaded": rateDownloaded,
        "status": status,
        "total_size": totalSize,
        "firebase_id": firebaseId,
      };
}
