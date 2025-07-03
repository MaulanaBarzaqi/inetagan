part of 'corporate_internetplan_bloc.dart';

sealed class CorporateInternetplanEvent extends Equatable {
  const CorporateInternetplanEvent();

  @override
  List<Object> get props => [];
}

class OnCorporateInternetplanEvent extends CorporateInternetplanEvent {}
