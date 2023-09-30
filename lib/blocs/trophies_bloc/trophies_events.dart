part of 'trophies_bloc.dart';

class TrophiesEvent extends Equatable {
  TrophiesEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrophies extends TrophiesEvent {
  LoadTrophies(this.titleId, this.groupId);
  final String titleId;
  final String groupId;
  @override
  List<Object?> get props => [titleId, groupId];
}