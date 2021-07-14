import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmessage.dart';
import 'package:rasp_torrent_flutter_app/models/torrentmodel.dart';
import 'package:rasp_torrent_flutter_app/repository/torrentrepository.dart';

part 'gettorrent_event.dart';
part 'gettorrent_state.dart';

class GetTorrentBloc extends Bloc<GetTorrentEvent, GetTorrentState> {
  final TorrentRepository torrentRepository;
  GetTorrentBloc(this.torrentRepository) : super(GetTorrentInitial());

  @override
  Stream<GetTorrentState> mapEventToState(
    GetTorrentEvent event,
  ) async* {
    if (event is GetTorrentEvent) {
      if (state is GetTorrentSuccess) {
        yield GetTorrentSuccess(
            torrentmodels: (state as GetTorrentSuccess).torrentmodels);
      } else if (state is GetTorrentEmpty) {
        yield GetTorrentEmpty(
            torrentmessage: (state as GetTorrentEmpty).torrentmessage);
      } else if (state is GetTorrentFailed) {
        yield GetTorrentFailed(
            torrentmessage: (state as GetTorrentFailed).torrentmessage);
      } else {
        yield GetTorrentLoading();
      }

      try {
        final dynamic response = await torrentRepository.fetchTorrent();

        if (response is List<TorrentModel>) {
          yield GetTorrentSuccess(torrentmodels: response);
        } else if (response is TorrentMessage) {
          yield GetTorrentEmpty(torrentmessage: response);
        }
      } catch (e) {
        yield GetTorrentFailed(
            torrentmessage: TorrentMessage(message: 'Something Went Wrong'));
      }
    }
  }
}
