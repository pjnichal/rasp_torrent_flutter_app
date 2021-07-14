import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rasp_torrent_flutter_app/business_logic/torrentoperationbloc/bloc/torrentoperationsbloc_bloc.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:getwidget/getwidget.dart';

class DownloadTile extends StatelessWidget {
  final TorrentModel torrent;
  bool isPause = false;
  DownloadTile({Key? key, required this.torrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
      child: Container(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 10.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GFProgressBar(
                  percentage: torrent.progress.toInt() / 100,
                  radius: 15.w,
                  circleWidth: 4,
                  progressBarColor: Colors.green,
                  animation: false,
                  autoLive: false,
                  child: Text(
                    torrent.progress.toInt().toString() + '%',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  type: GFProgressType.circular,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.h),
                child: SizedBox(
                  width: 50.w,
                  height: 9.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        torrent.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 3.7.w,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(
                        height: 0.8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            convertToString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 2.8.w,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            convertDownloadToString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 2.8.w,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<TorrentOperationsBloc, TorrentOperationsState>(
                  builder: (t, state) {
                return GestureDetector(
                  onTap: () {
                    if (torrent.isPause == 1) {
                      BlocProvider.of<TorrentOperationsBloc>(context)
                          .add(PauseTorrentEvent(torrent.firebaseId));
                      isPause = true;
                    } else {
                      BlocProvider.of<TorrentOperationsBloc>(context)
                          .add(StartTorrentEvent(torrent.firebaseId));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.h),
                    child: Icon(
                      (torrent.isPause == 1)
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      color: Colors.grey[400],
                      size: 8.w,
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (t) {
                        return SimpleDialog(
                          title: Text('Choose Option'),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                BlocProvider.of<TorrentOperationsBloc>(context)
                                    .add(
                                        DeleteTorrentEvent(torrent.firebaseId));
                                Navigator.of(t).pop();
                              },
                              child: Text('Delete from list'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                BlocProvider.of<TorrentOperationsBloc>(context)
                                    .add(DeleteWithDataTorrentEvent(
                                        torrent.firebaseId));
                                Navigator.of(t).pop();
                              },
                              child: Text('Delete from list and delete data'),
                            )
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 2.h),
                  child: Icon(
                    Icons.delete_rounded,
                    color: Colors.redAccent,
                    size: 8.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }

  String convertToString() {
    String downloadcompleted = '0';
    String totalsize =
        (torrent.totalSize > 1048576 && torrent.totalSize < 1073741824)
            ? (torrent.totalSize ~/ 1048576).toString() + ' MB'
            : ((torrent.totalSize > 1073741824)
                ? (torrent.totalSize / 1073741824).toStringAsFixed(2) + ' GB'
                : torrent.totalSize.toString());

    int totaldownloadinMB = (torrent.totalSize - torrent.leftUntilDone);
    if (totaldownloadinMB < 1048576) {
      downloadcompleted = '0/';
    } else if (torrent.totalSize > 1073741824) {
      downloadcompleted =
          (totaldownloadinMB / 1073741824).toStringAsFixed(2) + '/';
    } else {
      downloadcompleted =
          (totaldownloadinMB > 1048576 && totaldownloadinMB < 1073741824)
              ? (totaldownloadinMB ~/ 1048576).toString() + '/'
              : ((totaldownloadinMB > 1073741824)
                  ? (totaldownloadinMB / 1073741824).toStringAsFixed(2) + '/'
                  : totaldownloadinMB.toString() + '/');
    }
    final String result = downloadcompleted + totalsize;

    return result;
  }

  String convertDownloadToString() {
    double roundDouble(double value, int places) {
      num mod = pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }

    double truespeed = roundDouble(torrent.rateDownloaded / 1024, 2);
    String downspeed = (truespeed < 1 && truespeed < 1024)
        ? (truespeed / 1024).toStringAsFixed(1) + ' KB/S'
        : ((truespeed > 1024)
            ? (truespeed / 1024).toStringAsFixed(2) + ' MB/S'
            : (truespeed).toString() + ' KB/S');

    return downspeed;
  }
}
