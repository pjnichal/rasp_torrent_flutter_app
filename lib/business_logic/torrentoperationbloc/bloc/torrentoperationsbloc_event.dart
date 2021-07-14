part of 'torrentoperationsbloc_bloc.dart';

abstract class TorrentOperationsEvent extends Equatable {
  const TorrentOperationsEvent();

  @override
  List<Object> get props => [];
}

class PauseTorrentEvent extends TorrentOperationsEvent {
  final firebaseId;

  PauseTorrentEvent(this.firebaseId);
  @override
  List<Object> get props => [firebaseId];
}

class StartTorrentEvent extends TorrentOperationsEvent {
  final firebaseId;

  StartTorrentEvent(this.firebaseId);
  @override
  List<Object> get props => [firebaseId];
}

class DeleteTorrentEvent extends TorrentOperationsEvent {
  final firebaseId;

  DeleteTorrentEvent(this.firebaseId);
  @override
  List<Object> get props => [firebaseId];
}

class DeleteWithDataTorrentEvent extends TorrentOperationsEvent {
  final firebaseId;

  DeleteWithDataTorrentEvent(this.firebaseId);
  @override
  List<Object> get props => [firebaseId];
}

class AddTorrentEvent extends TorrentOperationsEvent {
  final magnetLink;

  AddTorrentEvent(this.magnetLink);
  @override
  List<Object> get props => [magnetLink];
}
