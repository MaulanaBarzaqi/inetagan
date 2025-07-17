part of 'search_internet_package_bloc.dart';

sealed class SearchInternetPackageEvent extends Equatable {
  const SearchInternetPackageEvent();

  @override
  List<Object> get props => [];
}

class OnSearchInternetPackageEvent extends SearchInternetPackageEvent {
  final String query;

  const OnSearchInternetPackageEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class OnResetInternetPackageEvent extends SearchInternetPackageEvent {}
