import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';
import 'package:inetagan/features/category/domain/usecases/get_all_categories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategories _usecase;

  CategoryCubit(this._usecase) : super(CategoryInitial());
  // Load semua categories dari API
  Future<void> loadCategories() async {
    emit(CategoryLoading());
    try {
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    } catch (e) {
      emit(CategoryError('failed to load categories: $e'));
    }
  }

  // Get categories dengan tambahan "All" option
  List<CategoryEntity> getCategoriesWithAll() {
    if (state is CategoryLoaded) {
      final loadedState = state as CategoryLoaded;
      return [
        CategoryEntity(
          id: 0,
          name: 'Semua Paket',
          slug: 'all',
          description: null,
          deletedAt: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ...loadedState.categories,
      ];
    }
    return [];
  }

  // Get category by slug
  CategoryEntity? getCategoryBySlug(String slug) {
    if (state is CategoryLoaded) {
      final loadedState = state as CategoryLoaded;
      return loadedState.categories.firstWhere(
        (category) => category.slug == slug,
        orElse: () => CategoryEntity(
          id: 0,
          name: 'Unknown',
          slug: 'unknown',
          description: null,
          deletedAt: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
    return null;
  }
}
