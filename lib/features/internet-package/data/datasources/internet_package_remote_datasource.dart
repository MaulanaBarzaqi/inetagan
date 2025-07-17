import 'package:http/http.dart' as http;
import 'package:inetagan/core/config/api_constant.dart';
import 'package:inetagan/core/config/app_request.dart';
import 'package:inetagan/core/config/app_response.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/features/internet-package/data/models/internet_package_model.dart';

abstract class InternetPackageRemoteDatasource {
  Future<List<InternetPackageModel>> all();
  Future<List<InternetPackageModel>> student();
  Future<List<InternetPackageModel>> family();
  Future<List<InternetPackageModel>> corporate();
  Future<List<InternetPackageModel>> search(String query);
}

class InternetPackageRemoteDatasourceImpl
    implements InternetPackageRemoteDatasource {
  final http.Client client;

  InternetPackageRemoteDatasourceImpl(this.client);

  @override
  Future<List<InternetPackageModel>> all() async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}/internet-packages/recommendation/limit',
    );
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetPackageModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }

  @override
  Future<List<InternetPackageModel>> corporate() async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}/internet-packages/category/corporate',
    );
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetPackageModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }

  @override
  Future<List<InternetPackageModel>> family() async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}/internet-packages/category/family',
    );
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetPackageModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }

  @override
  Future<List<InternetPackageModel>> search(String query) async {
    Uri url = Uri.parse('${AppConstant.baseUrl}${AppConstant.search(query)}');
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetPackageModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }

  @override
  Future<List<InternetPackageModel>> student() async {
    Uri url = Uri.parse(
      '${AppConstant.baseUrl}${AppConstant.category}/student',
    );
    final token = await AppSession.getBearerToken();
    final response = await client.get(url, headers: AppRequest.header(token));
    try {
      final data = AppResponse.data(response);
      final list = (data['data'] as List)
          .map((item) => InternetPackageModel.fromJson(item))
          .toList();
      return list;
    } catch (e) {
      throw Exception('Failed to load internet plans: $e');
    }
  }
}
