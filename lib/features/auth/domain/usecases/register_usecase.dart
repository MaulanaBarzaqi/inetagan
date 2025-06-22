import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/auth/domain/entities/register_entity.dart';
import 'package:inetagan/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _repository;

  RegisterUsecase(this._repository);

  Future<Either<Failure, RegisterEntity>> call(
    String name,
    String email,
    String password,
  ) {
    return _repository.register(name, email, password);
  }
}
