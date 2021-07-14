import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rasp_torrent_flutter_app/models/torrentmessage.dart';

class TorrentOperationProvider {
  final _baseUrl = 'https://myhometorrent.herokuapp.com';

  final http.Client httpClient;
  TorrentOperationProvider({
    required this.httpClient,
  });
  Future<TorrentMessage> pauseTorrent(firebaseId) async {
    final url = '$_baseUrl/pause/$firebaseId';

    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return TorrentMessage(message: 'Error');
    }
    final json = jsonDecode(response.body);

    if (json.containsKey('message')) {
      return torrentMessageFromJson(response.body);
    }
    return TorrentMessage(message: 'Error');
  }

  Future<TorrentMessage> startTorrent(firebaseId) async {
    final url = '$_baseUrl/start/$firebaseId';

    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return TorrentMessage(message: 'Error');
    }
    final json = jsonDecode(response.body);

    if (json.containsKey('message')) {
      return torrentMessageFromJson(response.body);
    }
    return TorrentMessage(message: 'Error');
  }

  Future<TorrentMessage> deleteTorrent(firebaseId) async {
    final url = '$_baseUrl/delete/$firebaseId';

    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return TorrentMessage(message: 'Error');
    }
    final json = jsonDecode(response.body);

    if (json.containsKey('message')) {
      return torrentMessageFromJson(response.body);
    }
    return TorrentMessage(message: 'Error');
  }

  Future<TorrentMessage> deletewithdataTorrent(firebaseId) async {
    final url = '$_baseUrl/deletewithdata/$firebaseId';
    print('===========================' + url);
    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return TorrentMessage(message: 'Error');
    }
    final json = jsonDecode(response.body);

    if (json.containsKey('message')) {
      return torrentMessageFromJson(response.body);
    }
    return TorrentMessage(message: 'Error');
  }

  Future<TorrentMessage> addTorrent(magnetLink) async {
    final url = '$_baseUrl/addTorrent';

    final response = await this.httpClient.post(
      Uri.parse(url),
      body: jsonEncode({
        'magnetlinks': magnetLink,
      }),
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      return TorrentMessage(message: 'Error');
    }
    final json = jsonDecode(response.body);

    if (json.containsKey('message')) {
      return torrentMessageFromJson(response.body);
    }
    return TorrentMessage(message: 'Error');
  }
}
