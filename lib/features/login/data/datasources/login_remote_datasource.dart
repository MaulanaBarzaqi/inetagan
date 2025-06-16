import 'package:inetagan/constants/api_constant.dart';
import 'package:inetagan/features/login/data/models/login_model.dart';
import 'package:dio/dio.dart';

abstract class LoginRemoteDatasource {
  Future<LoginModel> login(String email, String password);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final Dio dio;

  LoginRemoteDatasourceImpl(this.dio);

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await dio.post(
      '${ApiConstant.baseUrl}${ApiConstant.login}',
      data: {'email': email, 'password': password},
    );
    return LoginModel.fromMap(response.data);
  }
}
