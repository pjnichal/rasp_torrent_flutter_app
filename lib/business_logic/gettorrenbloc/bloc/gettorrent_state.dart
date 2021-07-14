part of 'gettorrent_bloc.dart';

abstract class GetTorrentState extends Equatable {
  const GetTorrentState();

  @override
  List<Object> get props => [];
}

class GetTorrentInitial extends GetTorrentState {}

class GetTorrentLoading extends GetTorrentState {}

class GetTorrentSuccess extends GetTorrentState {
  final List<TorrentModel> torrentmodels;
  GetTorrentSuccess({
    required this.torrentmodels,
  });
  @override
  List<Object> get props => [torrentmodels];
}

class GetTorrentEmpty extends GetTorrentState {
  final TorrentMessage torrentmessage;
  GetTorrentEmpty({
    required this.torrentmessage,
  });
  List<Object> get props => [torrentmessage];
}

class GetTorrentFailed extends GetTorrentState {
  final TorrentMessage torrentmessage;
  GetTorrentFailed({
    required this.torrentmessage,
  });
  List<Object> get props => [torrentmessage];
}
