import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/internet-package/data/datasources/internet_package_local_datasource.dart';
import 'package:inetagan/features/internet-package/data/datasources/internet_package_remote_datasource.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/domain/repositories/internet_package_repository.dart';

class InternetPackageRepositoryImpl implements InternetPackageRepository {
  final NetworkInfo networkInfo;
  final InternetPackageRemoteDatasource remoteDatasource;
  final InternetPackageLocalDatasource localDatasource;

  InternetPackageRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });
  @override
  Future<Either<Failure, List<InternetPackageEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cacheAll(result);
        final list = result.map((e) => e.toEntity).toList();
        return Right(list);
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
        final result = await localDatasource.getAll();
        final list = result.map((e) => e.toEntity).toList();
        return Right(list);
      } on CachedException {
        return Left(CachedFailure('data is not presents'));
      }
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> corporate() async {
    try {
      final result = await remoteDatasource.corporate();

      final list = result.map((e) => e.toEntity).toList();
      return Right(list);
    } on TimeoutException {
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something went wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> family() async {
    try {
      final result = await remoteDatasource.family();

      final list = result.map((e) => e.toEntity).toList();
      return Right(list);
    } on TimeoutException {
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something went wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> student() async {
    try {
      final result = await remoteDatasource.student();

      final list = result.map((e) => e.toEntity).toList();
      return Right(list);
    } on TimeoutException {
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something went wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> search(
    String query,
  ) async {
    try {
      final result = await remoteDatasource.search(query);

      final list = result.map((e) => e.toEntity).toList();
      return Right(list);
    } on TimeoutException {
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something went wrong: $e'));
    }
  }
}
