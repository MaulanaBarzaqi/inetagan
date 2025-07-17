part of 'student_package_bloc.dart';

sealed class StudentPackageState extends Equatable {
  const StudentPackageState();

  @override
  List<Object> get props => [];
}

final class StudentPackageInitial extends StudentPackageState {}

final class StudentPackageLoading extends StudentPackageState {}

final class StudentPackageSuccess extends StudentPackageState {
  final List<InternetPackageEntity> data;

  const StudentPackageSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class StudentPackageFailed extends StudentPackageState {
  final String message;

  const StudentPackageFailed(this.message);

  @override
  List<Object> get props => [message];
}
