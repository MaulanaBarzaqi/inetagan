import 'dart:convert';

import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/features/auth/data/models/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String name, String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<AuthModel> login(String email, String password) async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.login}');
    final response = await client.post(
      url,
      body: {'email': email, 'password': password},
    );
    final jsonData = jsonDecode(response.body);
    return AuthModel.fromLoginJson(jsonData);
  }

  @override
  Future<AuthModel> register(String name, String email, String password) async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.register}');
    final response = await client.post(
      url,
      body: {'name': name, 'email': email, 'password': password},
    );
    final jsonData = jsonDecode(response.body);
    return AuthModel.fromRegisterJson(jsonData);
  }
}
