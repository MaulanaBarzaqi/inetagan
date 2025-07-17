part of 'family_package_bloc.dart';

sealed class FamilyPackageState extends Equatable {
  const FamilyPackageState();

  @override
  List<Object> get props => [];
}

final class FamilyPackageInitial extends FamilyPackageState {}

final class FamilyPackageLoading extends FamilyPackageState {}

final class FamilyPackageSuccess extends FamilyPackageState {
  final List<InternetPackageEntity> data;

  const FamilyPackageSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class FamilyPackageFailed extends FamilyPackageState {
  final String message;

  const FamilyPackageFailed(this.message);

  @override
  List<Object> get props => [message];
}
