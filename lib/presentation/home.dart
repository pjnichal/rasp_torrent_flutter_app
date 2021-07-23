import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rasp_torrent_flutter_app/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:rasp_torrent_flutter_app/business_logic/gettorrenbloc/bloc/gettorrent_bloc.dart';
import 'package:rasp_torrent_flutter_app/presentation/downloadqueue.dart';
import 'package:rasp_torrent_flutter_app/presentation/downloadqueuestatus.dart';
import 'package:rasp_torrent_flutter_app/presentation/finishedqueuestatus.dart';
import 'package:rasp_torrent_flutter_app/presentation/finishedtorrent.dart';
import 'package:rasp_torrent_flutter_app/widgets/aboutdrawer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  @override
  void initState() {
    BlocProvider.of<GetTorrentBloc>(context).add(FetchTorrentEvent());
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) =>
            BlocProvider.of<GetTorrentBloc>(context).add(FetchTorrentEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Rasp Torrent",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/addtorrent');
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                )),
            SizedBox(width: 5.h),
            GestureDetector(
                onTap: () {
                  BlocProvider.of<ThemeCubit>(context).setAppTheme();
                },
                child: Icon(Icons.brightness_4, size: 30, color: Colors.white)),
            SizedBox(width: 5.h),
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  "Download Queue",
                  style: GoogleFonts.poppins(
                    fontSize: 4.5.w,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  "Finished",
                  style: GoogleFonts.poppins(
                    fontSize: 4.5.w,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: AboutDrawer(),
        body: SafeArea(
          child: BlocBuilder<GetTorrentBloc, GetTorrentState>(
              builder: (context, state) {
            if (state is GetTorrentSuccess) {
              return TabBarView(
                children: [
                  DownloadQueue(torrentlist: state.torrentmodels),
                  FinishedTorrent(torrentlist: state.torrentmodels)
                ],
              );
            } else if (state is GetTorrentFailed) {
              return TabBarView(children: [
                DownloadQueueStatus(isFailed: true, isEmpty: false),
                FinishedQueueStatus(isFailed: true, isEmpty: false),
              ]);
            } else if (state is GetTorrentEmpty) {
              return TabBarView(children: [
                DownloadQueueStatus(isFailed: false, isEmpty: true),
                FinishedQueueStatus(isFailed: false, isEmpty: true),
              ]);
            }
            return TabBarView(children: [
              DownloadQueueStatus(isFailed: false, isEmpty: false),
              FinishedQueueStatus(isFailed: false, isEmpty: false),
            ]);
          }),
        ),
      ),
    );
  }
}
