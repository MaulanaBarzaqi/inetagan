part of 'subscribe_bloc.dart';

abstract class SubscribeEvent extends Equatable {
  const SubscribeEvent();

  @override
  List<Object> get props => [];
}

final class OnSubscribeEvent extends SubscribeEvent {
  final String name;
  final String nik;
  final String phone;
  final String address;
  final int userId;
  final int internetPackageId;

  const OnSubscribeEvent({
    required this.name,
    required this.nik,
    required this.phone,
    required this.address,
    required this.userId,
    required this.internetPackageId,
  });

  @override
  List<Object> get props => [
    name,
    nik,
    phone,
    address,
    userId,
    internetPackageId,
  ];
}
