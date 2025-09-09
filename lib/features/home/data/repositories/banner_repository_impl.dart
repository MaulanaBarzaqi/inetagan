import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/home/data/datasources/banner_local_datasource.dart';
import 'package:inetagan/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:inetagan/features/home/domain/entities/banner_entity.dart';
import 'package:inetagan/features/home/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final NetworkInfo networkInfo;
  final BannerRemoteDatasource remoteDatasource;
  final BannerLocalDatasource localDatasource;

  BannerRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<BannerEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cacheBanners(result);

        final entities = result.map((model) => model.toEntity).toList();
        return Right(entities);
      } on TimeoutException {
        return Left(TimeoutFailure('Time out. no response'));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerException {
        return Left(ServerFailure('server error'));
      } catch (e) {
        return Left(ServerFailure('something went wrong: $e'));
      }
    } else {
      try {
        final cachedBanners = await localDatasource.getCachedBanners();
        final entities = cachedBanners.map((model) => model.toEntity).toList();
        return Right(entities);
      } on CachedException {
        return Left(CachedFailure('data is not presents'));
      }
    }
  }
}
