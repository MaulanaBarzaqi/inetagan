part of 'student_internetplan_bloc.dart';

sealed class StudentInternetplanEvent extends Equatable {
  const StudentInternetplanEvent();

  @override
  List<Object> get props => [];
}

class OnStudentInternetplanEvent extends StudentInternetplanEvent {}
