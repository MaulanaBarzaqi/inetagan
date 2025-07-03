part of 'all_internetplan_bloc.dart';

sealed class AllInternetplanEvent extends Equatable {
  const AllInternetplanEvent();

  @override
  List<Object> get props => [];
}

class OnAllInternetplanEvent extends AllInternetplanEvent {}
