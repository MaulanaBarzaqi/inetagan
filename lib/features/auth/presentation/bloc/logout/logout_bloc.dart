import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/auth/domain/usecases/logout_usecase.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUsecase _usecase;
  LogoutBloc(this._usecase) : super(LogoutInitial()) {
    on<OnLogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(LogoutFailure(failure.message)),
        (_) => emit(LogoutSuccess()),
      );
    });
  }
}
