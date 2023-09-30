part of 'trophy_groups_bloc.dart';

class TrophyGroupsEvents extends Equatable {
  const TrophyGroupsEvents();

  @override
  List<Object?> get props => [];
}

class LoadTrophyGroups extends TrophyGroupsEvents {
  const LoadTrophyGroups({required this.titleId});
  final String titleId;
  @override
  List<Object?> get props => [titleId];
}