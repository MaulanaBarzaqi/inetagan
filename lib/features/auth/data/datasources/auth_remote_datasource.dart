import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> signIn(String email, String password);
  Future<AuthModel> signUp(String name, String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl(this.client);

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
      return AuthModel.fromJson(jsonData);
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
}
