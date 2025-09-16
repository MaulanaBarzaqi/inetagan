import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/subscribe/data/datasources/subscribe_local_datasource.dart';
import 'package:inetagan/features/subscribe/data/datasources/subscribe_remote_datasource.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/repositories/subscribe_repository.dart';

class SubscribeRepositoryImpl implements SubscribeRepository {
  final NetworkInfo networkInfo;
  final SubscribeRemoteDatasource remoteDatasource;
  final SubscribeLocalDatasource localDatasource;

  SubscribeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, SubscribeEntity>> subscribe(
    String name,
    String nik,
    String phone,
    String address,
    int userId,
    int internetPackageId,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected();
      if (!isConnected) {
        return left(ConnnectionFailure('no internet connection'));
      }
      final result = await remoteDatasource.subscribe(
        name,
        nik,
        phone,
        address,
        userId,
        internetPackageId,
      );
      await localDatasource.cacheSubscription(result);
      return Right(result);
    } on TimeoutException {
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } on ForbiddenException {
      return Left(ForbiddenFailure('no access'));
    } on InvalidInputException {
      return Left(InvalidInputFailure('invalid data'));
    } on BadRequestException {
      return Left(BadRequestFailure('incorrect data format'));
    } catch (e) {
      return Left(ServerFailure('something went wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, SubscribeEntity>> getSubscription(int userId) async {
    try {
      final cachedSubscription = await localDatasource.getCachedSubscription();
      final isConnected = await networkInfo.isConnected();
      if (!isConnected) {
        if (cachedSubscription != null) {
          return Right(cachedSubscription);
        } else {
          return Left(
            ConnnectionFailure('No internet connection and no cached data'),
          );
        }
      }
      final result = await remoteDatasource.getSubscription(userId);
      await localDatasource.cacheSubscription(result);

      return Right(result);
    } on TimeoutException {
      final cachedSubscription = await localDatasource.getCachedSubscription();
      if (cachedSubscription != null) {
        return Right(cachedSubscription);
      }
      return Left(TimeoutFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message.toString()));
    } on ServerException {
      final cachedSubscription = await localDatasource.getCachedSubscription();
      if (cachedSubscription != null) {
        return Right(cachedSubscription);
      }
      return Left(ServerFailure('server error'));
    } on ForbiddenException {
      return Left(ForbiddenFailure('no access'));
    } on InvalidInputException {
      return Left(InvalidInputFailure('invalid data'));
    } on BadRequestException {
      return Left(BadRequestFailure('incorrect data format'));
    } catch (e) {
      final cachedSubscription = await localDatasource.getCachedSubscription();
      if (cachedSubscription != null) {
        return Right(cachedSubscription);
      }
      return Left(ServerFailure('something went wrong: $e'));
    }
  }
}
