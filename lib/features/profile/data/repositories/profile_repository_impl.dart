import 'package:inetagan/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';
import 'package:inetagan/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDatasource localDatasource;

  ProfileRepositoryImpl(this.localDatasource);
  @override
  Future<UserEntity?> getProfile() async {
    try {
      final profile = await localDatasource.getProfile();
      return profile;
    } catch (e) {
      throw Exception('Failed to get profile from repository: $e');
    }
  }
}
