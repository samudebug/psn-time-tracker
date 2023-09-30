import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trophies_repository/trophies_repository.dart';

part 'trophy_groups_events.dart';
part 'trophy_groups_states.dart';

class TrophyGroupsBloc extends Bloc<TrophyGroupsEvents, TrophyGroupsStates> {
  TrophyGroupsBloc({required this.trophiesRepository}): super(TrophyGroupsInitial()) {
    on<LoadTrophyGroups>(_loadTrophyGroups);

  }
  final TrophiesRepository trophiesRepository;

  Future<void> _loadTrophyGroups(LoadTrophyGroups event, Emitter<TrophyGroupsStates> emit) async {
    try {
      emit(TrophyGroupsLoading());
      final trophyGroups = await trophiesRepository.getTrophyGroups(event.titleId);
      emit(TrophyGroupsReady(trophyGroups));
    } catch (e) {
      print(e);
      emit(TrophyGroupsFailed());
    }
  }
}