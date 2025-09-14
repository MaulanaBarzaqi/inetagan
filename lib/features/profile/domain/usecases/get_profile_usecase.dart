import 'package:inetagan/features/profile/domain/entities/user_entity.dart';
import 'package:inetagan/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository _repository;

  GetProfileUsecase(this._repository);

  Future<UserEntity?> call() async {
    return await _repository.getProfile();
  }
}
