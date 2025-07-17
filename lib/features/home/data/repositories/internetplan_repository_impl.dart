import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/home/data/datasources/internetplan_local_datasource.dart';
import 'package:inetagan/features/home/data/datasources/internetplan_remote_datasource.dart';
import 'package:inetagan/features/home/domain/entities/internetplan_entity.dart';
import 'package:inetagan/features/home/domain/repositories/internetplan_repository.dart';

class InternetplanRepositoryImpl implements InternetplanRepository {
  final NetworkInfo networkInfo;
  final InternetPlanRemoteDatasource remoteDatasource;
  final InternetplanLocalDatasource localDatasource;

  InternetplanRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<InternetplanEntity>>> all() async {
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
}
