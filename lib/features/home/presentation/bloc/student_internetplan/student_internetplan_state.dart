part of 'student_internetplan_bloc.dart';

sealed class StudentInternetplanState extends Equatable {
  const StudentInternetplanState();

  @override
  List<Object> get props => [];
}

final class StudentInternetplanInitial extends StudentInternetplanState {}

final class StudentInternetplanLoading extends StudentInternetplanState {}

final class StudentInternetplanSuccess extends StudentInternetplanState {
  final List<InternetplanEntity> data;

  const StudentInternetplanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class StudentInternetplanFailed extends StudentInternetplanState {
  final String message;

  const StudentInternetplanFailed(this.message);
}
