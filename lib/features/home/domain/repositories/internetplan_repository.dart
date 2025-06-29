import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';

abstract class InternetplanRepository {
  Future<Either<Failure, List<InternetplanEntity>>> all();
  Future<Either<Failure, List<InternetplanEntity>>> searchInternetPlan(
    String query,
  );
  Future<Either<Failure, List<InternetplanEntity>>> student();
  Future<Either<Failure, List<InternetplanEntity>>> family();
  Future<Either<Failure, List<InternetplanEntity>>> corporate();
}
