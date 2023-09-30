import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_states.dart';
part 'profile_events.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
  }
  final ProfileRepository profileRepository;

  Future<void> _loadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    try {

      emit(ProfileLoading());
      final profile = await profileRepository.getProfile();
      emit(ProfileReady(profile));
    } catch (e) {
      emit(ProfileFailed());
    }
  }
}