part of 'corporate_internetplan_bloc.dart';

sealed class CorporateInternetplanState extends Equatable {
  const CorporateInternetplanState();

  @override
  List<Object> get props => [];
}

final class CorporateInternetplanInitial extends CorporateInternetplanState {}

final class CorporateInternetplanLoading extends CorporateInternetplanState {}

final class CorporateInternetplanSuccess extends CorporateInternetplanState {
  final List<InternetplanEntity> data;

  const CorporateInternetplanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class CorporateInternetplanFailed extends CorporateInternetplanState {
  final String message;

  const CorporateInternetplanFailed(this.message);

  @override
  List<Object> get props => [message];
}
