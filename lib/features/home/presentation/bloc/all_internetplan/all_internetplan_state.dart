part of 'all_internetplan_bloc.dart';

sealed class AllInternetplanState extends Equatable {
  const AllInternetplanState();

  @override
  List<Object> get props => [];
}

final class AllInternetplanInitial extends AllInternetplanState {}

final class AllInternetplanLoading extends AllInternetplanState {}

final class AllInternetplanSuccess extends AllInternetplanState {
  final List<InternetplanEntity> data;

  const AllInternetplanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class AllInternetplanFailed extends AllInternetplanState {
  final String message;

  const AllInternetplanFailed(this.message);

  @override
  List<Object> get props => [message];
}
