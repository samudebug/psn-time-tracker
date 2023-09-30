import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trophies_repository/trophies_repository.dart';

part 'trophies_events.dart';
part 'trophies_states.dart';

class TrophiesBloc extends Bloc<TrophiesEvent, TrophiesState> {
  TrophiesBloc({required this.trophiesRepository, required this.authRepository}) : super(TrophiesInitial()) {
    on<LoadTrophies>(_loadTrophies);
  }
  final TrophiesRepository trophiesRepository;
  final AuthRepository authRepository;

  Future<void> _loadTrophies(LoadTrophies event, Emitter<TrophiesState> emit) async {
    try {
      emit(TrophiesLoading());
      final token = await authRepository.getToken();
      final trophies = await trophiesRepository.getTrophies(event.titleId, event.groupId, token);
      emit(TrophiesReady(trophies));
    } catch (e) {
      print(e);
      emit(TrophiesFailed());
    }
  }
}