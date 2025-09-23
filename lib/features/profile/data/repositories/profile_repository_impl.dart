import 'package:inetagan/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:inetagan/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:inetagan/features/profile/domain/entities/user_entity.dart';
import 'package:inetagan/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDatasource localDatasource;
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<UserEntity?> getProfile() async {
    try {
      final profile = await localDatasource.getProfile();
      return profile;
    } catch (e) {
      throw Exception('Failed to get profile from repository: $e');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await remoteDatasource.logOut();
    } catch (e) {
      throw Exception('Failed to logout from repository: $e');
    }
  }
}
