import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';

part 'games_events.dart';
part 'games_states.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc({required this.gamesRepository}) : super(GamesInitial()) {
    on<LoadGames>(_loadGames);
  }
  final GamesRepository gamesRepository;

  Future<void> _loadGames(GamesEvent event, Emitter<GamesState> emit) async {
    try {
      emit(GamesLoading());
      final games = await gamesRepository.getGames();
      emit(GamesReady(games));
    } catch (e) {
      emit(GamesFailed());
    }
  }
}