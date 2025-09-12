import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

abstract class InternetPackageRepository {
  Future<Either<Failure, List<InternetPackageEntity>>> all();
  Future<Either<Failure, List<InternetPackageEntity>>> search(String query);
  Future<Either<Failure, List<InternetPackageEntity>>> getByCategory(
    String categorySlug,
  );
}
