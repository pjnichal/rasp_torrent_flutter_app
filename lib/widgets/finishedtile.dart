import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rasp_torrent_flutter_app/business_logic/torrentoperationbloc/bloc/torrentoperationsbloc_bloc.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:getwidget/getwidget.dart';

class FinishedTile extends StatelessWidget {
  final TorrentModel torrent;
  const FinishedTile({Key? key, required this.torrent}) : super(key: key);

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
                  radius: 60,
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
                          fontSize: 14,
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
                            (torrent.totalSize > 1048576 &&
                                    torrent.totalSize < 1073741824)
                                ? (torrent.totalSize ~/ 1048576).toString() +
                                    ' MB'
                                : ((torrent.totalSize > 1073741824)
                                    ? (torrent.totalSize / 1073741824)
                                            .toStringAsFixed(2) +
                                        ' GB'
                                    : torrent.totalSize.toString()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            torrent.status.capitalize(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
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
                  builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (torrent.isPause == 1) {
                      BlocProvider.of<TorrentOperationsBloc>(context)
                          .add(PauseTorrentEvent(torrent.firebaseId));
                    } else {
                      BlocProvider.of<TorrentOperationsBloc>(context)
                          .add(StartTorrentEvent(torrent.firebaseId));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.h),
                    child: Icon(
                      (torrent.isPause == 1)
                          ? Icons.stop
                          : Icons.play_circle_fill_rounded,
                      color: Colors.grey[400],
                      size: 8.w,
                    ),
                  ),
                );
              }),
              // Padding(
              //   padding: EdgeInsets.only(right: 2.h),
              //   child: Icon(
              //     Icons.stop,
              //     color: Colors.grey[400],
              //     size: 8.w,
              //   ),
              // ),
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
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
// BlocBuilder<TorrentOperationsBloc, TorrentOperationsState>(
//                   builder: (context, state) {
//                 return GestureDetector(
//                   onTap: () {
//                     if (torrent.isPause == 1) {
//                       BlocProvider.of<TorrentOperationsBloc>(context)
//                           .add(PauseTorrentEvent(torrent.firebaseId));
//                       isPause = true;
//                     } else {
//                       BlocProvider.of<TorrentOperationsBloc>(context)
//                           .add(StartTorrentEvent(torrent.firebaseId));
//                     }
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 2.h),
//                     child: Icon(
//                       (torrent.isPause == 1)
//                           ? Icons.pause_circle_filled_rounded
//                           : Icons.play_circle_fill_rounded,
//                       color: Colors.grey[400],
//                       size: 8.w,
//                     ),
//                   ),
//                 );
//               }),
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (t) {
//                         return SimpleDialog(
//                           title: Text('Choose Option'),
//                           children: [
//                             SimpleDialogOption(
//                               onPressed: () {
//                                 BlocProvider.of<TorrentOperationsBloc>(context)
//                                     .add(
//                                         DeleteTorrentEvent(torrent.firebaseId));
//                                 Navigator.of(t).pop();
//                               },
//                               child: Text('Delete from list'),
//                             ),
//                             SimpleDialogOption(
//                               onPressed: () {
//                                 BlocProvider.of<TorrentOperationsBloc>(context)
//                                     .add(DeleteWithDataTorrentEvent(
//                                         torrent.firebaseId));
//                                 Navigator.of(t).pop();
//                               },
//                               child: Text('Delete from list and delete data'),
//                             )
//                           ],
//                         );
//                       });
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 2.h),
//                   child: Icon(
//                     Icons.delete_rounded,
//                     color: Colors.redAccent,
//                     size: 8.w,
//                   ),
//                 ),
//               ),