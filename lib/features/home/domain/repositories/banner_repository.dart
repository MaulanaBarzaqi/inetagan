import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<BannerEntity>>> all();
}
