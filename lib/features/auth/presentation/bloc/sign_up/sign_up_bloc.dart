import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/usecases/sign_up_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUsecase _usecase;

  SignUpBloc(this._usecase) : super(SignUpInitial()) {
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
