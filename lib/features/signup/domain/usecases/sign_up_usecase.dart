import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/signup/domain/entities/sign_up_entity.dart';
import 'package:inetagan/features/signup/domain/repositories/sign_up_repository.dart';

class SignUpUsecase {
  final SignUpRepository _repository;

  SignUpUsecase(this._repository);

  Future<Either<Failure, SignUpEntity>> call(
    String name,
    String email,
    String password,
  ) {
    return _repository.signUp(name, email, password);
  }
}
