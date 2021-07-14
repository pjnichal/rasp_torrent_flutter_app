import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rasp_torrent_flutter_app/repository/torrentoperationsrepository.dart';

part 'torrentoperationsbloc_event.dart';
part 'torrentoperationsbloc_state.dart';

class TorrentOperationsBloc
    extends Bloc<TorrentOperationsEvent, TorrentOperationsState> {
  final TorrentOperationRepository torrentOperationRepository;
  TorrentOperationsBloc(this.torrentOperationRepository)
      : super(TorrentOperationsInitial());

  @override
  Stream<TorrentOperationsState> mapEventToState(
    TorrentOperationsEvent event,
  ) async* {
    if (event is AddTorrentEvent) {
      final torrentMessage =
          await torrentOperationRepository.addTorrent(event.magnetLink);
      print(torrentMessage.message);
      if (torrentMessage.message != 'Error') {
        yield AddedTorrentSuccess();
      } else {
        yield AddedTorrentFailed();
      }
    } else if (event is PauseTorrentEvent) {
      print('sadsad');
      final torrentMessage =
          await torrentOperationRepository.pauseTorrent(event.firebaseId);

      if (torrentMessage.message != 'Error') {
        yield PauseTorrentSuccess();
      } else {
        yield PauseTorrentFailed();
      }
    } else if (event is StartTorrentEvent) {
      final torrentMessage =
          await torrentOperationRepository.startTorrent(event.firebaseId);
      if (torrentMessage.message != 'Error') {
        yield StartTorrentSuccess();
      } else {
        yield StartTorrentFailed();
      }
    } else if (event is DeleteTorrentEvent) {
      final torrentMessage =
          await torrentOperationRepository.deleteTorrent(event.firebaseId);
      if (torrentMessage.message != 'Error') {
        yield DeleteTorrentSuccess();
      } else {
        yield DeleteTorrentFailed();
      }
    } else if (event is DeleteWithDataTorrentEvent) {
      print('done');
      final torrentMessage = await torrentOperationRepository
          .deletewithdataTorrent(event.firebaseId);
      if (torrentMessage.message != 'Error') {
        yield DeleteWithDataTorrentSuccess();
      } else {
        yield DeleteWithDataTorrentFailed();
      }
    }
    // TODO: implement mapEventToState
  }
}
