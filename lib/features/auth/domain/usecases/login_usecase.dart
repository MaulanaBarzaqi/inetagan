import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/login_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<Either<Failure, LoginEntity>> call(String email, String password) {
    return _repository.login(email, password);
  }
}
