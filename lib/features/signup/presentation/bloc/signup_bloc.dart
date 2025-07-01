import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/signup/domain/entities/sign_up_entity.dart';
import 'package:inetagan/features/signup/domain/usecases/sign_up_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUsecase _usecase;

  SignupBloc(this._usecase) : super(SignUpInitial()) {
    on<OnSignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      final result = await _usecase.call(
        event.name,
        event.email,
        event.password,
      );
      result.fold(
        (failure) => emit(SignUpFailed(failure.message)),
        (data) => emit(SignUpSuccess(data)),
      );
    });
  }
}
