class AppConstant {
  static const appName = 'Inetagan';
  static const _host = 'http://192.168.100.13:8000';

  /// ``` baseUrl = 'http://192.168.100.52:8000' ```
  static const baseUrl = '$_host/api';
  static const register = '/register';
  static const login = '/login';
  static const sendFcmToken = '/update-fcm-token';
  static const removeFcmToken = '/remove-fcm-token';
  static const banner = '/banners/list';
  static const categories = '/categories/list';
  static const internetPlans = '/internet-packages/list';
  static String getByCategory(String categorySlug) =>
      '/internet-packages/category/$categorySlug';
  static String search(String query) => '/internet-packages/search/$query';
  static String imagePackage(String imageName) => '$_host/storage/$imageName';
  static String imageBanner(String imageName) => '$_host/storage/$imageName';
  static const subscribe = '/internet-installations/create';
  static String getInstallation(int userId) =>
      '/internet-installations/user/$userId';
}
