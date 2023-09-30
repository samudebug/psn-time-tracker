import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_states.dart';
part 'profile_events.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository, required this.authRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
  }
  final ProfileRepository profileRepository;
  final AuthRepository authRepository;
  Future<void> _loadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    try {

      emit(ProfileLoading());
      final token = await authRepository.getToken();
      final profile = await profileRepository.getProfile(token);
      emit(ProfileReady(profile));
    } catch (e) {
      print(e);
      emit(ProfileFailed());
    }
  }
}