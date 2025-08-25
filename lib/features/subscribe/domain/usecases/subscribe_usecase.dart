import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/repositories/subscribe_repository.dart';

class SubscribeUsecase {
  final SubscribeRepository _repository;

  SubscribeUsecase(this._repository);

  Future<Either<Failure, SubscribeEntity>> call(
    String name,
    String nik,
    String phone,
    String address,
    int userId,
    int internetPackageId,
  ) {
    return _repository.subscribe(
      name,
      nik,
      phone,
      address,
      userId,
      internetPackageId,
    );
  }
}
