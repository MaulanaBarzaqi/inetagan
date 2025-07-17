part of 'corporate_package_bloc.dart';

sealed class CorporatePackageState extends Equatable {
  const CorporatePackageState();

  @override
  List<Object> get props => [];
}

final class CorporatePackageInitial extends CorporatePackageState {}

final class CorporatePackageLoading extends CorporatePackageState {}

final class CorporatePackageSuccess extends CorporatePackageState {
  final List<InternetPackageEntity> data;

  const CorporatePackageSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class CorporatePackageFailed extends CorporatePackageState {
  final String message;

  const CorporatePackageFailed(this.message);

  @override
  List<Object> get props => [message];
}
