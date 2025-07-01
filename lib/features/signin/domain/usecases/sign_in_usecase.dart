import 'package:dartz/dartz.dart';
import 'package:inetagan/core/errors/failures.dart';
import 'package:inetagan/features/signin/domain/entities/sign_in_entity.dart';
import 'package:inetagan/features/signin/domain/repositories/sign_in_repository.dart';

class SignInUsecase {
  final SignInRepository _repository;

  SignInUsecase(this._repository);

  Future<Either<Failure, SignInEntity>> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}
