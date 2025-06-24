import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _usecase;
  RegisterBloc(this._usecase) : super(RegisterInitial()) {
    on<OnRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await _usecase.call(
        event.name,
        event.email,
        event.password,
      );
      result.fold(
        (failure) => emit(RegisterFailed(failure.message)),
        (register) => emit(RegisterSuccess(register)),
      );
    });
  }
}
