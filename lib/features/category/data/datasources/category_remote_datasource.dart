import 'package:extended_image/extended_image.dart' as http;
import 'package:inetagan/core/config/app_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:inetagan/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> allCategories();
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final http.Client client;
  final AuthLocalDatasource localDatasource;

  CategoryRemoteDatasourceImpl({
    required this.client,
    required this.localDatasource,
  });

  @override
  Future<List<CategoryModel>> allCategories() async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.categories}');
    final token = await localDatasource.getCachedToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('failed to load Categories: $e');
    }
  }
}
