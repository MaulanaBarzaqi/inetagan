class AppConstant {
  static const appName = 'Inetagan';
  static const _host = 'http://192.168.100.52:8000';

  /// ``` baseUrl = 'http://192.168.100.52:8000' ```
  static const baseUrl = '$_host/api';
  static const register = '/register';
  static const login = '/login';
  static const internetPlans = '/internet-packages/recomendation/limit';
  static const banner = '/banners/list';
  static const category = '/internet-packages/category';
  static String search(String query) => '/internet-packages/search/$query';
  static String imagePackage(String imageName) => '$_host/storage/$imageName';
  static String imageBanner(String imageName) => '$_host/storage/$imageName';
}
