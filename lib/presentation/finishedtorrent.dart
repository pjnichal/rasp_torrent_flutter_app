import 'package:flutter/material.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';

import 'package:rasp_torrent_flutter_app/widgets/finishedtile.dart';

class FinishedTorrent extends StatelessWidget {
  final List<TorrentModel> torrentlist;
  const FinishedTorrent({Key? key, required this.torrentlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView.builder(
        itemCount: torrentlist.length,
        itemBuilder: (BuildContext buildContext, int index) {
          if (torrentlist[index].progress == 100) {
            return FinishedTile(torrent: torrentlist[index]);
          }
          return Container();
        },
      ),
    );
  }
}
