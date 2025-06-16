import 'package:inetagan/features/home/presentation/pages/home_page.dart';
import 'package:inetagan/features/login/presentation/pages/login_page.dart';

enum MyRoute {
  login('/login'),
  home('/home');

  final String name;
  const MyRoute(this.name);
}

final routes = {
  MyRoute.login.name: (context) => const LoginPage(),
  MyRoute.home.name: (context) => const HomePage(),
};
