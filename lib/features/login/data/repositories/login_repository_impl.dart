import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/login/data/datasources/login_remote_datasource.dart';
import 'package:inetagan/features/login/domain/entities/login_entity.dart';
import 'package:inetagan/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});
  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await loginRemoteDataSource.login(email, password);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
