import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';
import 'package:inetagan/features/profile/domain/usecases/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase _usecase;

  ProfileCubit(this._usecase) : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _usecase.call();
      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        emit(ProfileEmpty());
      }
    } catch (e) {
      emit(ProfileError('Failed to load profile'));
    }
  }
}
