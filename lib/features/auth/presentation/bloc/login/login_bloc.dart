import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/auth/domain/entities/user_entity.dart';
import 'package:inetagan/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _usecase;
  LoginBloc(this._usecase) : super(LoginInitial()) {
    on<OnLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await _usecase.call(event.email, event.password);
      result.fold(
        (failure) => emit(LoginFailed(failure.message)),
        (login) => emit(LoginSuccess(data: login.data, token: login.token)),
      );
    });
  }
}
