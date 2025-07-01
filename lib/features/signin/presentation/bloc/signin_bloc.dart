import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';
import 'package:inetagan/features/signin/domain/usecases/sign_in_usecase.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SignInUsecase _usecase;

  SigninBloc(this._usecase) : super(SignInInitial()) {
    on<OnSignInEvent>((event, emit) async {
      emit(SignInLoading());
      final result = await _usecase.call(event.email, event.password);

      result.fold(
        (failure) => emit(SignInFailed(failure.message)),
        (data) => emit(SignInSuccess(data)),
      );
    });
  }
}
