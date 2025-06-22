import 'package:go_router/go_router.dart';
import 'package:inetagan/features/auth/presentation/pages/register_page.dart';
import 'package:inetagan/features/home/presentation/pages/home_page.dart';
import 'package:inetagan/features/auth/presentation/pages/landing_page.dart';
import 'package:inetagan/features/auth/presentation/pages/login_page.dart';

class RouteNames {
  static const landing = 'landing';
  static const login = 'login';
  static const register = 'register';
  static const home = 'home';
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.landing,
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      name: RouteNames.login,
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: RouteNames.register,
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      name: RouteNames.home,
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
  ],
);
