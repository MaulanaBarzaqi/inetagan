import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/category/data/datasources/category_local_datasource.dart';
import 'package:inetagan/features/category/data/datasources/category_remote_datasource.dart';
import 'package:inetagan/features/category/domain/entities/category_entity.dart';
import 'package:inetagan/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final NetworkInfo networkInfo;
  final CategoryRemoteDatasource remoteDatasource;
  final CategoryLocalDatasource localDatasource;

  CategoryRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> allCategories() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.allCategories();
        await localDatasource.cacheCategories(result);

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
        final cachedCategories = await localDatasource.getCachedCategories();
        final entities = cachedCategories
            .map((model) => model.toEntity)
            .toList();
        return Right(entities);
      } on CachedException catch (e) {
        return Left(CachedFailure(e.message));
      } catch (e) {
        return Left(CachedFailure('Failed to load cached categories: $e'));
      }
    }
  }
}
