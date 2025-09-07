import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/core/platform/network_info.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_local_datasource.dart';
import 'package:inetagan/features/signin/data/datasources/sign_in_remote_datasource.dart';
import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';
import 'package:inetagan/features/signin/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDatasource remoteDatasource;
  final SignInLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  SignInRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SignInEntity>> signIn(
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
      await localDatasource.cacheToken(result.token);

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
