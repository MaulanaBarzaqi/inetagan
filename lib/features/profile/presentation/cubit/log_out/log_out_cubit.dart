import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/profile/domain/usecases/log_out_usecase.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final LogOutUsecase _usecase;

  LogOutCubit(this._usecase) : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await _usecase.call();
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutError('Failed to logout: $e'));
    }
  }
}
