import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/repositories/internet_package_repository.dart';

class SearchInternetPackageUsecase {
  final InternetPackageRepository _repository;

  SearchInternetPackageUsecase(this._repository);

  Future<Either<Failure, List<InternetPackageEntity>>> call(String query) {
    return _repository.search(query);
  }
}
