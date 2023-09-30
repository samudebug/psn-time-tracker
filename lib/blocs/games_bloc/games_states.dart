part of 'games_bloc.dart';

class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

class GamesInitial extends GamesState {}

class GamesLoading extends GamesState {}

class GamesReady extends GamesState {
  final List<Game> games;

  const GamesReady(this.games);

  @override  
  List<Object?> get props => [];
}

class GamesFailed extends GamesState {}