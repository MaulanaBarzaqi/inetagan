import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/signup/data/models/sign_up_model.dart';

abstract class SignUpRemoteDatasource {
  Future<SignUpModel> signUp(String name, String email, String password);
}

class SignUpRemoteDatasourceImpl implements SignUpRemoteDatasource {
  final http.Client client;

  SignUpRemoteDatasourceImpl(this.client);

  @override
  Future<SignUpModel> signUp(String name, String email, String password) async {
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
      return SignUpModel.fromJson(jsonData);
    } on TimeoutException {
      throw TimeoutException('Request timeout.');
    } catch (e) {
      rethrow;
    }
  }
}
