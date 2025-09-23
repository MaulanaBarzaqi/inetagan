import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';

abstract class ProfileRemoteDatasource {
  Future<void> logOut();
  Future<void> removeFcmToken();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final http.Client client;
  final AuthLocalDatasource localDatasource;

  ProfileRemoteDatasourceImpl({
    required this.client,
    required this.localDatasource,
  });

  @override
  Future<void> logOut() async {
    try {
      await removeFcmToken();
      await localDatasource.clearUserData();
      await localDatasource.removeToken();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  @override
  Future<void> removeFcmToken() async {
    try {
      final token = await localDatasource.getCachedToken();
      if (token == null) {
        print('no token found, skipping FCM token removal from server');
      }
      Uri url = Uri.parse(
        '${AppConstant.baseUrl}${AppConstant.removeFcmToken}',
      );
      final response = await client
          .post(url, headers: AppRequest.header(token))
          .timeout(Duration(seconds: 10));
      AppResponse.data(response);
      print('fcm token removed from servser successfully');
    } catch (e) {
      print('Failed to remove FCM token from server: $e');
    }
  }
}
