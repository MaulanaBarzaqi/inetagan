import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/signup/data/datasources/sign_up_remote_datasource.dart';
import 'package:inetagan/features/signup/domain/entities/sign_up_entity.dart';
import 'package:inetagan/features/signup/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDatasource signUpRemoteDatasource;

  SignUpRepositoryImpl({required this.signUpRemoteDatasource});

  @override
  Future<Either<Failure, SignUpEntity>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await signUpRemoteDatasource.signUp(name, email, password);
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
