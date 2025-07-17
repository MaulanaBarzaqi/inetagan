part of 'all_internet_package_bloc.dart';

sealed class AllInternetPackageState extends Equatable {
  const AllInternetPackageState();

  @override
  List<Object> get props => [];
}

final class AllInternetPackageInitial extends AllInternetPackageState {}

final class AllInternetPackageLoading extends AllInternetPackageState {}

final class AllInternetPackageSuccess extends AllInternetPackageState {
  final List<InternetPackageEntity> data;

  const AllInternetPackageSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class AllInternetPackageFailed extends AllInternetPackageState {
  final String message;

  const AllInternetPackageFailed(this.message);

  @override
  List<Object> get props => [message];
}
