import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasp_torrent_flutter_app/business_logic/gettorrenbloc/bloc/gettorrent_bloc.dart';
import 'package:rasp_torrent_flutter_app/business_logic/torrentoperationbloc/bloc/torrentoperationsbloc_bloc.dart';
import 'package:rasp_torrent_flutter_app/presentation/addtorrent.dart';
import 'package:rasp_torrent_flutter_app/presentation/home.dart';
import 'package:rasp_torrent_flutter_app/provider/torrentoperationsprovider.dart';
import 'package:rasp_torrent_flutter_app/provider/torrentprovider.dart';
import 'package:rasp_torrent_flutter_app/repository/torrentoperationsrepository.dart';
import 'package:rasp_torrent_flutter_app/repository/torrentrepository.dart';
import 'package:http/http.dart' as http;

class AppRouter {
  final torrentOperationsBloc = TorrentOperationsBloc(
      TorrentOperationRepository(
          torrentoperationsprovider:
              TorrentOperationProvider(httpClient: http.Client())));
  final gettorrenbloc = GetTorrentBloc(
    TorrentRepository(
      torrentProvider: TorrentProvider(
        httpClient: http.Client(),
      ),
    ),
  );

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetTorrentBloc>(
                create: (context) => gettorrenbloc,
              ),
              BlocProvider<TorrentOperationsBloc>(
                create: (context) => torrentOperationsBloc,
              ),
            ],
            child: HomeScreen(),
          ),
        );

      case '/addtorrent':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TorrentOperationsBloc(
                TorrentOperationRepository(
                    torrentoperationsprovider:
                        TorrentOperationProvider(httpClient: http.Client()))),
            child: AddTorrent(),
          ),
        );
    }
  }

  void dispose() {
    gettorrenbloc.close();
  }
}
