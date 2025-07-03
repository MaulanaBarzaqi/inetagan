part of 'family_internetplan_bloc.dart';

sealed class FamilyInternetplanState extends Equatable {
  const FamilyInternetplanState();

  @override
  List<Object> get props => [];
}

final class FamilyInternetplanInitial extends FamilyInternetplanState {}

final class FamilyInternetplanLoading extends FamilyInternetplanState {}

final class FamilyInternetplanSuccess extends FamilyInternetplanState {
  final List<InternetplanEntity> data;

  const FamilyInternetplanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class FamilyInternetplanFailed extends FamilyInternetplanState {
  final String message;

  const FamilyInternetplanFailed(this.message);

  @override
  List<Object> get props => [message];
}
