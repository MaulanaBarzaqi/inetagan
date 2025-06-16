import 'package:go_router/go_router.dart';
import 'package:inetagan/features/home/presentation/pages/home_page.dart';
import 'package:inetagan/features/login/presentation/pages/login_page.dart';

class RouteNames {
  static const login = 'login';
  static const home = 'home';
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.login,
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: RouteNames.home,
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
  ],
);
