import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/usecases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUsecase _usecase;

  SignInBloc(this._usecase) : super(SignInInitial()) {
    on<OnSignInEvent>((event, emit) async {
      emit(SignInLoading());
      final result = await _usecase.call(event.email, event.password);

      result.fold(
        (failure) => emit(SignInFailed(failure)),
        (data) => emit(SignInSuccess(data)),
      );
    });
  }
}
