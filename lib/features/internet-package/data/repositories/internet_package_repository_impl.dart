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
    final bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cacheInternetPackages(result);

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
        final cachedPackages = await localDatasource
            .getCachedInternetPackages();
        final entities = cachedPackages.map((model) => model.toEntity).toList();

        return Right(entities);
      } on CachedException catch (e) {
        return Left(CachedFailure(e.message));
      } catch (e) {
        return Left(CachedFailure('failed to load cached packages: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> search(
    String query,
  ) async {
    final bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.search(query);

        final entities = result.map((model) => model.toEntity).toList();
        return Right(entities);
      } on TimeoutException {
        return Left(TimeoutFailure('Time out. no response'));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerException {
        return Left(ServerFailure('server error'));
      } catch (e) {
        return Left(ServerFailure('failed to search packages: $e'));
      }
    } else {
      try {
        final cachedPackages = await localDatasource
            .getCachedInternetPackages();
        final searchedPackages = cachedPackages
            .where(
              (package) =>
                  package.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        final entities = searchedPackages
            .map((model) => model.toEntity)
            .toList();
        return Right(entities);
      } on CachedException catch (e) {
        return Left(CachedFailure(e.message));
      } catch (e) {
        return Left(CachedFailure('Failed to search cached packages: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> getByCategory(
    String categorySlug,
  ) async {
    final bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.getByCategory(categorySlug);
        final entities = result.map((model) => model.toEntity).toList();

        return Right(entities);
      } on TimeoutException {
        return Left(TimeoutFailure('Time out. no response'));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerException {
        return Left(ServerFailure('server error'));
      } catch (e) {
        return Left(ServerFailure('Failed to load packages by category: $e'));
      }
    } else {
      try {
        final cachedPackages = await localDatasource
            .getCachedInternetPackages();
        final filteredPackages = cachedPackages
            .where((package) => package.category?.slug == categorySlug)
            .toList();
        final entities = filteredPackages
            .map((model) => model.toEntity)
            .toList();
        return Right(entities);
      } on CachedException catch (e) {
        return Left(CachedFailure(e.message));
      } catch (e) {
        return Left(CachedFailure('Failed to filter cached packages: $e'));
      }
    }
  }
}
