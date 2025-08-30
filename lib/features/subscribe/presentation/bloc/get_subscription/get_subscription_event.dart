part of 'get_subscription_bloc.dart';

sealed class GetSubscriptionEvent extends Equatable {
  const GetSubscriptionEvent();

  @override
  List<Object> get props => [];
}

final class OnGetSubscriptionEvent extends GetSubscriptionEvent {
  final int userId;

  const OnGetSubscriptionEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
