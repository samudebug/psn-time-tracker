import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';

part 'games_events.dart';
part 'games_states.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc({required this.gamesRepository, required this.authRepository}) : super(GamesInitial()) {
    on<LoadGames>(_loadGames);
  }
  final GamesRepository gamesRepository;
  final AuthRepository authRepository;

  Future<void> _loadGames(GamesEvent event, Emitter<GamesState> emit) async {
    try {
      emit(GamesLoading());
      var token = await authRepository.getToken();
      final games = await gamesRepository.getGames(token);
      emit(GamesReady(games));
    } catch (e) {
      emit(GamesFailed());
    }
  }
}