part of 'logout_bloc.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

final class OnLogoutEvent extends LogoutEvent {
  const OnLogoutEvent();

  @override
  List<Object> get props => [];
}
