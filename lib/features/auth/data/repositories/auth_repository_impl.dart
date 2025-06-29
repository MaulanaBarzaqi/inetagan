import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDatasource.login(email, password);

      await authLocalDatasource.saveUser(result);
      await authLocalDatasource.saveBearerToken(result.token!);

      return Right(result);
    } on TimeoutException {
      return Left(NotfoundFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotfoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something when wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDatasource.register(name, email, password);
      return Right(result);
    } on TimeoutException {
      return Left(NotfoundFailure('Time out. no response'));
    } on NotFoundException catch (e) {
      return Left(NotfoundFailure(e.message.toString()));
    } on ServerException {
      return Left(ServerFailure('server error'));
    } catch (e) {
      return Left(ServerFailure('something when wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authLocalDatasource.removeUser();
      await authLocalDatasource.removeBearerToken();
      return Right(null);
    } catch (e) {
      return Left(CachedFailure('something when wrong: $e'));
    }
  }
}
