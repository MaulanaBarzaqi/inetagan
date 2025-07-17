import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/usecases/get_student_package_usecase.dart';

part 'student_package_event.dart';
part 'student_package_state.dart';

class StudentPackageBloc
    extends Bloc<StudentPackageEvent, StudentPackageState> {
  final GetStudentPackageUsecase _usecase;

  StudentPackageBloc(this._usecase) : super(StudentPackageInitial()) {
    on<OnStudentPackageEvent>((event, emit) async {
      emit(StudentPackageLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(StudentPackageFailed(failure.message)),
        (data) => emit(StudentPackageSuccess(data)),
      );
    });
  }
}
