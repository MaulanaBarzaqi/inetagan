part of 'subscribe_bloc.dart';

abstract class SubscribeState extends Equatable {
  const SubscribeState();

  @override
  List<Object> get props => [];
}

class SubscribeInitial extends SubscribeState {}

class SubscribeLoading extends SubscribeState {}

class SubscribeSuccess extends SubscribeState {
  final SubscribeEntity data;

  const SubscribeSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class SubscribeFailed extends SubscribeState {
  final String message;

  const SubscribeFailed(this.message);

  @override
  List<Object> get props => [message];
}
