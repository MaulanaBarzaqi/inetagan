import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/auth_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository _repository;

  SignInUsecase(this._repository);

  Future<Either<Failure, AuthEntity>> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}
