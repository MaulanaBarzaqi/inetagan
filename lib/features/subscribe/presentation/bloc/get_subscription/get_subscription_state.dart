part of 'get_subscription_bloc.dart';

sealed class GetSubscriptionState extends Equatable {
  const GetSubscriptionState();

  @override
  List<Object> get props => [];
}

final class GetSubscriptionInitial extends GetSubscriptionState {}

final class GetSubscriptionLoading extends GetSubscriptionState {}

final class GetSubscriptionSuccess extends GetSubscriptionState {
  final SubscribeEntity data;

  const GetSubscriptionSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class GetSubscriptionFailed extends GetSubscriptionState {
  final String message;

  const GetSubscriptionFailed(this.message);

  @override
  List<Object> get props => [message];
}
