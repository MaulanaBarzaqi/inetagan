import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/home/data/models/banner_model.dart';

abstract class BannerRemoteDatasource {
  Future<List<BannerModel>> all();
}

class BannerRemoteDatasourceImpl implements BannerRemoteDatasource {
  final http.Client client;
  final AuthLocalDatasource localDatasource;

  BannerRemoteDatasourceImpl({
    required this.client,
    required this.localDatasource,
  });

  @override
  Future<List<BannerModel>> all() async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.banner}');
    final token = await localDatasource.getCachedToken();
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
