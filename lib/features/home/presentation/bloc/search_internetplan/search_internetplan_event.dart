part of 'search_internetplan_bloc.dart';

sealed class SearchInternetplanEvent extends Equatable {
  const SearchInternetplanEvent();

  @override
  List<Object> get props => [];
}

class OnSearchInternetplanEvent extends SearchInternetplanEvent {
  final String query;

  const OnSearchInternetplanEvent(this.query);

  @override
  List<Object> get props => [query];
}
