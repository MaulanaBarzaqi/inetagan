part of 'search_internet_package_bloc.dart';

sealed class SearchInternetPackageState extends Equatable {
  const SearchInternetPackageState();

  @override
  List<Object> get props => [];
}

final class SearchInternetPackageInitial extends SearchInternetPackageState {}

final class SearchInternetPackageLoading extends SearchInternetPackageState {}

final class SearchInternetPackageSuccess extends SearchInternetPackageState {
  final List<InternetPackageEntity> data;

  const SearchInternetPackageSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SearchInternetPackageFailed extends SearchInternetPackageState {
  final String message;

  const SearchInternetPackageFailed(this.message);

  @override
  List<Object> get props => [message];
}
