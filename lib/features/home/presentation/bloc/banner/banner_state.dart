part of 'banner_bloc.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerSuccess extends BannerState {
  final List<BannerEntity> data;

  const BannerSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class BannerFailed extends BannerState {
  final String message;

  const BannerFailed(this.message);

  @override
  List<Object> get props => [message];
}
