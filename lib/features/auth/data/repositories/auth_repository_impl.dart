import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, AuthEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected();
      if (!isConnected) {
        return Left(ConnnectionFailure('Tidak ada koneksi internet'));
      }
      final result = await remoteDatasource.signIn(email, password);
      await localDatasource.cacheUser(result);
      await localDatasource.cacheToken(result.token!);

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
  Future<Either<Failure, AuthEntity>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected();
      if (!isConnected) {
        return Left(ConnnectionFailure('tidak ada koneksi internet'));
      }
      final result = await remoteDatasource.signUp(name, email, password);
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
