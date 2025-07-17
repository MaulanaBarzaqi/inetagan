import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/home/data/models/internetplan_model.dart';

abstract class InternetPlanRemoteDatasource {
  Future<List<InternetplanModel>> all();
}

class InternetplanRemoteDatasourceImpl implements InternetPlanRemoteDatasource {
  final http.Client client;

  InternetplanRemoteDatasourceImpl(this.client);

  @override
  Future<List<InternetplanModel>> all() async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}/internet-packages/recommendation/limit',
    );
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetplanModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }
}
