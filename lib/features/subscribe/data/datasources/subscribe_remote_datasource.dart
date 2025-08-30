import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/subscribe/data/models/subscribe_model.dart';

abstract class SubscribeRemoteDatasource {
  Future<SubscribeModel> subscribe(
    String name,
    String nik,
    String phone,
    String address,
    int userId,
    int internetPackageId,
  );
  Future<SubscribeModel> getSubscription(int userId);
}

class SubscribeRemoteDatasourceImpl implements SubscribeRemoteDatasource {
  final http.Client client;

  SubscribeRemoteDatasourceImpl(this.client);

  @override
  Future<SubscribeModel> subscribe(
    String name,
    String nik,
    String phone,
    String address,
    int userId,
    int internetPackageId,
  ) async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.subscribe}');
    try {
      final token = await AppSession.getBearerToken();
      final response = await client.post(
        url,
        headers: AppRequest.header(token),
        body: {
          'name': name,
          'nik': nik,
          'phone': phone,
          'address': address,
          'user_id': userId.toString(),
          'internet_package_id': internetPackageId.toString(),
        },
      );
      final jsonData = AppResponse.data(response);
      final data = SubscribeModel.fromJson(jsonData);
      return data;
    } catch (e) {
      throw Exception('Failed to subscribe: $e');
    }
  }

  @override
  Future<SubscribeModel> getSubscription(int userId) async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}${AppConstant.getInstallation(userId)}',
    );
    try {
      final token = await AppSession.getBearerToken();
      final response = await client.get(url, headers: AppRequest.header(token));
      final jsonData = AppResponse.data(response);

      final data = SubscribeModel.fromJsonRead(jsonData);
      return data;
    } catch (e) {
      throw Exception('Failed to get subscription: $e');
    }
  }
}
