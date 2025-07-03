import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/repositories/internetplan_repository.dart';

class SearchInternetplanUsecase {
  final InternetplanRepository _repository;

  SearchInternetplanUsecase(this._repository);

  Future<Either<Failure, List<InternetplanEntity>>> call(String query) {
    return _repository.searchInternetPlan(query);
  }
}
