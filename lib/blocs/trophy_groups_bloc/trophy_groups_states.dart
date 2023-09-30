part of 'trophy_groups_bloc.dart';

class TrophyGroupsStates extends Equatable {
  const TrophyGroupsStates();

  @override
  List<Object?> get props => [];
}

class TrophyGroupsInitial extends TrophyGroupsStates {}

class TrophyGroupsLoading extends TrophyGroupsStates {}

class TrophyGroupsReady extends TrophyGroupsStates {
  const TrophyGroupsReady(this.trophyGroups);
  final List<TrophyGroup> trophyGroups;

  @override  
  List<Object?> get props => [trophyGroups];
}
class TrophyGroupsFailed extends TrophyGroupsStates {}