part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity profile;

  const ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

class ProfileEmpty extends ProfileState {}
