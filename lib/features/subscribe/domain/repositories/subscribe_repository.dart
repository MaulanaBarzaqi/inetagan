import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';

abstract class SubscribeRepository {
  Future<Either<Failure, SubscribeEntity>> subscribe(
    String name,
    String nik,
    String phone,
    String address,
    int userId,
    int internetPackageId,
  );
}
