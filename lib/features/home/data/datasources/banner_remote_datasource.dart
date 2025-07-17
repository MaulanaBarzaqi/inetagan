import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/home/data/models/banner_model.dart';

abstract class BannerRemoteDatasource {
  Future<List<BannerModel>> all();
}

class BannerRemoteDatasourceImpl implements BannerRemoteDatasource {
  final http.Client client;

  BannerRemoteDatasourceImpl(this.client);

  @override
  Future<List<BannerModel>> all() async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.banner}');
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => BannerModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('failed to load banner list: $e');
    }
  }
}
