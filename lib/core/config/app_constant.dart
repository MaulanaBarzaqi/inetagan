class AppConstant {
  static const appName = 'Inetagan';
  static const _host = 'https://inetagan.my.id';

  /// ``` baseUrl = 'https://inetagan.my.id' ```
  static const baseUrl = '$_host/api';
  static const register = '/register';
  static const login = '/login';
  static const sendFcmToken = '/update-fcm-token';
  static const removeFcmToken = '/remove-fcm-token';
  static const banner = '/banners';
  static const categories = '/categories';
  static const internetPlans = '/internet-packages';
  static String getByCategory(String categorySlug) =>
      '/internet-packages/category/$categorySlug';
  static String search(String query) => '/internet-packages/search/$query';
  static String imagePackage(String imageName) => '$_host/storage/$imageName';
  static String imageBanner(String imageName) => '$_host/storage/$imageName';
  static const subscribe = '/internet-installations/create';
  static String getInstallation(int userId) =>
      '/internet-installations/user/$userId';
}
