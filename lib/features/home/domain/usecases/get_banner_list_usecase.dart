import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/domain/repositories/banner_repository.dart';

class GetBannerListUsecase {
  final BannerRepository _repository;

  GetBannerListUsecase(this._repository);
  Future<Either<Failure, List<BannerEntity>>> call() {
    return _repository.all();
  }
}
