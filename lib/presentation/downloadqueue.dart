import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';
import 'package:rasp_torrent_flutter_app/widgets/downloadtile.dart';

class DownloadQueue extends StatelessWidget {
  final List<TorrentModel> torrentlist;
  const DownloadQueue({Key? key, required this.torrentlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int isHas = 0;
    for (TorrentModel t in torrentlist) {
      if (t.progress != 100) {
        isHas = 1;
      }
    }
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
      child: (isHas == 0)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('The Queue is Empty'),
              ],
            )
          : ListView.builder(
              itemCount: torrentlist.length,
              itemBuilder: (BuildContext buildContext, int index) {
                if (torrentlist[index].progress == 100) {
                  return Container();
                } else if (torrentlist[index].progress != 100) {
                  isHas++;
                  return DownloadTile(torrent: torrentlist[index]);
                }

                if (isHas == 0) {
                  return Text('Empty');
                }
                print('this is happening');
                return Container();
              },
            ),
    );
  }
}
 