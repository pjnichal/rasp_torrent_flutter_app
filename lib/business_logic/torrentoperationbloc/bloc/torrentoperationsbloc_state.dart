part of 'torrentoperationsbloc_bloc.dart';

abstract class TorrentOperationsState extends Equatable {
  const TorrentOperationsState();

  @override
  List<Object> get props => [];
}

class TorrentOperationsInitial extends TorrentOperationsState {}

class PauseTorrentSuccess extends TorrentOperationsState {}

class PauseTorrentFailed extends TorrentOperationsState {}

class StartTorrentSuccess extends TorrentOperationsState {}

class StartTorrentFailed extends TorrentOperationsState {}

class DeleteTorrentSuccess extends TorrentOperationsState {}

class DeleteTorrentFailed extends TorrentOperationsState {}

class DeleteWithDataTorrentSuccess extends TorrentOperationsState {}

class DeleteWithDataTorrentFailed extends TorrentOperationsState {}

class AddedTorrentSuccess extends TorrentOperationsState {}

class AddedTorrentFailed extends TorrentOperationsState {}
