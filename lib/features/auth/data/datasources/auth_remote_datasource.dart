import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/core/services/fcm_service.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> signIn(String email, String password);
  Future<AuthModel> signUp(String name, String email, String password);
  Future<void> updateFcmToken(String fcmToken);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  final FcmService fcmService;
  final AuthLocalDatasource localDatasource;

  AuthRemoteDatasourceImpl({
    required this.localDatasource,
    required this.client,
    required this.fcmService,
  });

  @override
  Future<AuthModel> signIn(String email, String password) async {
    try {
      Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.login}');
      final response = await client
          .post(
            url,
            body: {'email': email, 'password': password},
            headers: AppRequest.header(),
          )
          .timeout(Duration(seconds: 30));

      final jsonData = AppResponse.data(response);
      final authModel = AuthModel.fromJson(jsonData);
      // bearer token
      if (authModel.token != null) {
        await localDatasource.cacheToken(authModel.token!);
      }
      // fcm token
      final fcmToken = await fcmService.getFcmToken();
      if (fcmToken != null) {
        await updateFcmToken(fcmToken);
      }
      return authModel;
    } on TimeoutException {
      throw TimeoutException('Request timeout.');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthModel> signUp(String name, String email, String password) async {
    try {
      Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.register}');
      final response = await client
          .post(
            url,
            body: {'name': name, 'email': email, 'password': password},
            headers: AppRequest.header(),
          )
          .timeout(Duration(seconds: 30));

      final jsonData = AppResponse.data(response);
      return AuthModel.fromJson(jsonData);
    } on TimeoutException {
      throw TimeoutException('Request timeout.');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateFcmToken(String fcmToken) async {
    try {
      Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.sendFcmToken}');
      final token = await localDatasource.getCachedToken();
      final response = await client.post(
        url,
        headers: AppRequest.header(token),
        body: {'fcm_token': fcmToken},
      );
      AppResponse.data(response);
      print('FCM token updated successfully: $fcmToken');
    } catch (e) {
      print('Error updating FCM token: $e');
      // Jangan throw error agar login tetap berhasil meskipun FCM gagal
    }
  }
}
