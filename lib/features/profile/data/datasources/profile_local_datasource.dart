import 'package:inetagan/core/errors/exceptions.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/profile/data/models/user_model.dart';

abstract class ProfileLocalDatasource {
  Future<UserModel?> getProfile();
  Future<void> logOut();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final AuthLocalDatasource authLocalDatasource;

  ProfileLocalDatasourceImpl(this.authLocalDatasource);
  @override
  Future<UserModel?> getProfile() async {
    try {
      final authModel = await authLocalDatasource.getCachedUser();

      if (authModel == null) {
        throw CachedException('No user data found');
      }
      return UserModel.fromAuthModel(authModel);
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await authLocalDatasource.clearUserData();
      await authLocalDatasource.removeToken();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
