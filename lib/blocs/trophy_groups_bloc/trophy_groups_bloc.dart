import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trophies_repository/trophies_repository.dart';

part 'trophy_groups_events.dart';
part 'trophy_groups_states.dart';

class TrophyGroupsBloc extends Bloc<TrophyGroupsEvents, TrophyGroupsStates> {
  TrophyGroupsBloc({required this.trophiesRepository, required this.authRepository}): super(TrophyGroupsInitial()) {
    on<LoadTrophyGroups>(_loadTrophyGroups);

  }
  final TrophiesRepository trophiesRepository;
  final AuthRepository authRepository;

  Future<void> _loadTrophyGroups(LoadTrophyGroups event, Emitter<TrophyGroupsStates> emit) async {
    try {
      emit(TrophyGroupsLoading());
      final token = await authRepository.getToken();
      final trophyGroups = await trophiesRepository.getTrophyGroups(event.titleId, token);
      emit(TrophyGroupsReady(trophyGroups));
    } catch (e) {
      print(e);
      emit(TrophyGroupsFailed());
    }
  }
}