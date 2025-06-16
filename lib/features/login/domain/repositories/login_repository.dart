import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
}
