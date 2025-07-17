part of 'family_package_bloc.dart';

sealed class FamilyPackageEvent extends Equatable {
  const FamilyPackageEvent();

  @override
  List<Object> get props => [];
}

class OnFamilyPackageEvent extends FamilyPackageEvent {}
