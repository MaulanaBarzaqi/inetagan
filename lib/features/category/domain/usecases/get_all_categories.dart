import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';
import 'package:inetagan/features/category/domain/repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository _repository;

  GetAllCategories(this._repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return _repository.allCategories();
  }
}
