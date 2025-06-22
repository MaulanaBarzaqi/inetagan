import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:inetagan/features/auth/data/models/register_model.dart';
import 'package:inetagan/features/auth/domain/entities/login_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDatasource.login(email, password);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDatasource.register(name, email, password);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
