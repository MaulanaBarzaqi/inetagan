part of 'student_package_bloc.dart';

sealed class StudentPackageEvent extends Equatable {
  const StudentPackageEvent();

  @override
  List<Object> get props => [];
}

class OnStudentPackageEvent extends StudentPackageEvent {}
