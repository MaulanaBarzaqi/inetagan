import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_local_datasource.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_remote_datasource.dart';
import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';
import 'package:inetagan/features/signin/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDatasource signInRemoteDatasource;
  final SignInLocalDatasource signInLocalDatasource;

  SignInRepositoryImpl({
    required this.signInLocalDatasource,
    required this.signInRemoteDatasource,
  });

  @override
  Future<Either<Failure, SignInEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await signInRemoteDatasource.signIn(email, password);

      await signInLocalDatasource.saveUser(result);
      await signInLocalDatasource.saveBearerToken(result.token);

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
