part of 'get_by_category_bloc.dart';

sealed class GetByCategoryEvent extends Equatable {
  const GetByCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetByCategoryEvent extends GetByCategoryEvent {
  final String categorySlug;

  const OnGetByCategoryEvent(this.categorySlug);

  @override
  List<Object> get props => [categorySlug];
}

class OnResetGetByCategoryEvent extends GetByCategoryEvent {}
