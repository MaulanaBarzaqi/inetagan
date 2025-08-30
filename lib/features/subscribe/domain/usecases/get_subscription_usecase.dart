import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/repositories/subscribe_repository.dart';

class GetSubscriptionUsecase {
  final SubscribeRepository _repository;

  GetSubscriptionUsecase(this._repository);

  Future<Either<Failure, SubscribeEntity>> call(int userId) {
    return _repository.getSubscription(userId);
  }
}
