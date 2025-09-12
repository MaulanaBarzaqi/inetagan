part of 'get_by_category_bloc.dart';

sealed class GetByCategoryState extends Equatable {
  const GetByCategoryState();

  @override
  List<Object> get props => [];
}

final class GetByCategoryInitial extends GetByCategoryState {}

final class GetByCategoryLoading extends GetByCategoryState {}

final class GetByCategorySuccess extends GetByCategoryState {
  final List<InternetPackageEntity> data;

  const GetByCategorySuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class GetByCategoryFailed extends GetByCategoryState {
  final String message;

  const GetByCategoryFailed(this.message);

  @override
  List<Object> get props => [message];
}
