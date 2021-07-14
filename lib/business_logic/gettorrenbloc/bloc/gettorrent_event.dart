part of 'gettorrent_bloc.dart';

abstract class GetTorrentEvent extends Equatable {
  const GetTorrentEvent();
}

class FetchTorrentEvent extends GetTorrentEvent {
  @override
  List<Object?> get props => [];
}
