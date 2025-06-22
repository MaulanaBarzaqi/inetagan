import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/data/models/register_model.dart';
import 'package:inetagan/features/auth/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
  Future<Either<Failure, RegisterModel>> register(
    String name,
    String email,
    String password,
  );
}
