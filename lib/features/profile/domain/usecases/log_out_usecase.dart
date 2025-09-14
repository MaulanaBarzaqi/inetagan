import 'package:inetagan/features/profile/domain/repositories/profile_repository.dart';

class LogOutUsecase {
  final ProfileRepository _repository;

  LogOutUsecase(this._repository);

  Future<void> call() async {
    return await _repository.logOut();
  }
}
