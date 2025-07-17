import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/repositories/internet_package_repository.dart';

class GetStudentPackageUsecase {
  final InternetPackageRepository _repository;

  GetStudentPackageUsecase(this._repository);

  Future<Either<Failure, List<InternetPackageEntity>>> call() {
    return _repository.student();
  }
}
