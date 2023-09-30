import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trophies_repository/trophies_repository.dart';

part 'trophies_events.dart';
part 'trophies_states.dart';

class TrophiesBloc extends Bloc<TrophiesEvent, TrophiesState> {
  TrophiesBloc({required this.trophiesRepository}) : super(TrophiesInitial()) {
    on<LoadTrophies>(_loadTrophies);
  }
  final TrophiesRepository trophiesRepository;

  Future<void> _loadTrophies(LoadTrophies event, Emitter<TrophiesState> emit) async {
    try {
      emit(TrophiesLoading());
      final trophies = await trophiesRepository.getTrophies(event.titleId, event.groupId);
      print("trophies $trophies");
      emit(TrophiesReady(trophies));
    } catch (e) {
      print(e);
      emit(TrophiesFailed());
    }
  }
}