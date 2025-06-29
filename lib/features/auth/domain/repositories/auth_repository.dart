import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  Future<Either<Failure, AuthEntity>> register(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, void>> logout();
}
