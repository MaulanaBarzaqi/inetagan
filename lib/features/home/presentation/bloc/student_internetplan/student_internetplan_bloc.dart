import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/usecases/get_student_internetplan_usecase.dart';

part 'student_internetplan_event.dart';
part 'student_internetplan_state.dart';

class StudentInternetplanBloc
    extends Bloc<StudentInternetplanEvent, StudentInternetplanState> {
  final GetStudentInternetplanUsecase _usecase;

  StudentInternetplanBloc(this._usecase) : super(StudentInternetplanInitial()) {
    on<OnStudentInternetplanEvent>((event, emit) async {
      emit(StudentInternetplanLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(StudentInternetplanFailed(failure.message)),
        (data) => emit(StudentInternetplanSuccess(data)),
      );
    });
  }
}
