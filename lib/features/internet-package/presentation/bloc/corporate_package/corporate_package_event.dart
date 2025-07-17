part of 'corporate_package_bloc.dart';

sealed class CorporatePackageEvent extends Equatable {
  const CorporatePackageEvent();

  @override
  List<Object> get props => [];
}

class OnCorporatePackageEvent extends CorporatePackageEvent {}
