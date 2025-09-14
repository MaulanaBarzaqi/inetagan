import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signIn(String email, String password);
  Future<Either<Failure, AuthEntity>> signUp(
    String name,
    String email,
    String password,
  );
}
