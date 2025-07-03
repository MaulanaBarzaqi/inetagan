part of 'search_internetplan_bloc.dart';

sealed class SearchInternetplanState extends Equatable {
  const SearchInternetplanState();

  @override
  List<Object> get props => [];
}

final class SearchInternetplanInitial extends SearchInternetplanState {}

final class SearchInternetplanLoading extends SearchInternetplanState {}

final class SearchInternetplanSuccess extends SearchInternetplanState {
  final List<InternetplanEntity> data;

  const SearchInternetplanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SearchInternetplanFailed extends SearchInternetplanState {
  final String message;

  const SearchInternetplanFailed(this.message);

  @override
  List<Object> get props => [message];
}
