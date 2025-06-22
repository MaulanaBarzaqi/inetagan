import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/features/auth/data/models/login_model.dart';
import 'package:inetagan/features/auth/data/models/register_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> login(String email, String password);
  Future<RegisterModel> register(String name, String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await dio.post(
      '${AppConstant.baseUrl}${AppConstant.login}',
      data: {'email': email, 'password': password},
      // options: dio.Options(headers: {'Accept': 'application/json'}),
    );
    // DMethod.printResponse(response.data);
    return LoginModel.fromMap(response.data);
  }

  @override
  Future<RegisterModel> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await dio.post(
      '${AppConstant.baseUrl}${AppConstant.register}',
      data: {'name': name, 'email': email, 'password': password},
      // options: dio.Options(headers: {'Accept': 'application/json'}),
    );
    // DMethod.printResponse(response);
    final data = RegisterModel.fromMap(response.data);
    return data;
  }
}
