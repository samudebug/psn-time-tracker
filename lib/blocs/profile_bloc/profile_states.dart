part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileReady extends ProfileState {
  const ProfileReady(this.profile);
  final Profile profile;

  @override
  List<Object?> get props => [profile];
}

class ProfileFailed extends ProfileState {}