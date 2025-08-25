import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/subscribe/data/datasources/subscribe_remote_datasource.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/domain/repositories/subscribe_repository.dart';

class SubscribeRepositoryImpl implements SubscribeRepository {
  final SubscribeRemoteDatasource remoteDatasource;

  SubscribeRepositoryImpl({required this.remoteDatasource});

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
      final result = await remoteDatasource.subscribe(
        name,
        nik,
        phone,
        address,
        userId,
        internetPackageId,
      );
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
}
