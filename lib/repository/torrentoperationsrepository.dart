import 'package:rasp_torrent_flutter_app/models/torrentmessage.dart';
import 'package:rasp_torrent_flutter_app/provider/torrentoperationsprovider.dart';

class TorrentOperationRepository {
  final TorrentOperationProvider torrentoperationsprovider;

  TorrentOperationRepository({required this.torrentoperationsprovider});
  Future<TorrentMessage> pauseTorrent(firebaseId) async {
    return torrentoperationsprovider.pauseTorrent(firebaseId);
  }

  Future<TorrentMessage> startTorrent(firebaseId) async {
    return torrentoperationsprovider.startTorrent(firebaseId);
  }

  Future<TorrentMessage> deleteTorrent(firebaseId) async {
    return torrentoperationsprovider.deleteTorrent(firebaseId);
  }

  Future<TorrentMessage> deletewithdataTorrent(firebaseId) async {
    return torrentoperationsprovider.deletewithdataTorrent(firebaseId);
  }

  Future<TorrentMessage> addTorrent(magnetLink) async {
    return torrentoperationsprovider.addTorrent(magnetLink);
  }
}
