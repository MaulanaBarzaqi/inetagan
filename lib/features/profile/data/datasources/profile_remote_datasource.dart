import 'package:d_method/d_method.dart';
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
        DMethod.logTitle(
          'SKIP FCM REMOVAL',
          'No auth token found\nSkipping FCM token removal from server',
          titleCode: 226, // Kuning - warning
        );
        return;
      }
      Uri url = Uri.parse(
        '${AppConstant.baseUrl}${AppConstant.removeFcmToken}',
      );
      final response = await client
          .post(url, headers: AppRequest.header(token))
          .timeout(Duration(seconds: 10));
      AppResponse.data(response);
      DMethod.logTitle(
        '✅ FCM TOKEN REMOVED',
        'Status: ${response.statusCode}\nFCM token successfully removed from server',
      );
    } catch (e) {
      DMethod.logTitle(
        'FCM REMOVAL FAILED',
        'Error: $e\nFailed to remove FCM token from server',
      );
    }
  }
}
