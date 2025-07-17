part of 'all_internet_package_bloc.dart';

sealed class AllInternetPackageEvent extends Equatable {
  const AllInternetPackageEvent();

  @override
  List<Object> get props => [];
}

class OnAllInternetPackageEvent extends AllInternetPackageEvent {}
