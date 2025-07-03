import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/repositories/internetplan_repository.dart';

class GetStudentInternetplanUsecase {
  final InternetplanRepository _repository;

  GetStudentInternetplanUsecase(this._repository);

  Future<Either<Failure, List<InternetplanEntity>>> call() {
    return _repository.student();
  }
}
