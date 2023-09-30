part of 'trophies_bloc.dart';

class TrophiesState extends Equatable {
  TrophiesState();

  @override  
  List<Object?> get props => [];
}

class TrophiesInitial extends TrophiesState {}

class TrophiesLoading extends TrophiesState {}

class TrophiesFailed extends TrophiesState {}

class TrophiesReady extends TrophiesState {
  TrophiesReady(this.trophies);
  final List<Trophy> trophies;
  @override  
  List<Object?> get props => [trophies];
}