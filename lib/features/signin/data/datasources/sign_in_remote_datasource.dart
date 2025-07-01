import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';

abstract class SignInRemoteDatasource {
  Future<SignInModel> signIn(String email, String password);
}

class SignInRemoteDatasourceImpl implements SignInRemoteDatasource {
  final http.Client client;

  SignInRemoteDatasourceImpl(this.client);

  @override
  Future<SignInModel> signIn(String email, String password) async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.login}');
    final response = await client.post(
      url,
      body: {'email': email, 'password': password},
      headers: AppRequest.header(),
    );
    final jsonData = AppResponse.data(response);
    return SignInModel.fromJson(jsonData);
  }
}
