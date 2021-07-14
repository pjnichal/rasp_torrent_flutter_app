import 'package:rasp_torrent_flutter_app/provider/torrentprovider.dart';

class TorrentRepository {
  final TorrentProvider torrentProvider;
  TorrentRepository({required this.torrentProvider});
  Future<dynamic> fetchTorrent() async {
    return torrentProvider.fetchTorrent();
  }
}
