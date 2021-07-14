import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rasp_torrent_flutter_app/models/torrentmessage.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';

class TorrentProvider {
  final _baseUrl = 'https://myhometorrent.herokuapp.com';
  final http.Client httpClient;
  TorrentProvider({
    required this.httpClient,
  });

  Future<dynamic> fetchTorrent() async {
    final url = '$_baseUrl/getAllTorrent';

    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return TorrentMessage(message: 'something went wrong');
    }
    final json = jsonDecode(response.body);

    bool isList = json is List;
    if (!isList) {
      if (json.containsKey('message')) {
        return torrentMessageFromJson(response.body);
      }
    } else {
      return torrentModelFromJson(response.body);
    }
  }
}
