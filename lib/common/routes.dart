import 'package:go_router/go_router.dart';
import 'package:inetagan/features/home/presentation/pages/dashboard.dart';
import 'package:inetagan/features/home/presentation/pages/home_page.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';
import 'package:inetagan/features/internet-package/presentation/pages/detail_page.dart';
import 'package:inetagan/features/internet-package/presentation/pages/all_packages_page.dart';
import 'package:inetagan/features/signin/presentation/pages/landing_page.dart';
import 'package:inetagan/features/signin/presentation/pages/sign_in_page.dart';
import 'package:inetagan/features/signup/presentation/pages/sign_up_page.dart';

class RouteNames {
  static const landing = 'landing';
  static const signin = 'signin';
  static const signup = 'signup';
  static const dashboard = 'dashboard';
  static const home = 'home';
  static const detail = 'detail';
  static const internetPackages = 'internetPackages';
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.landing,
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      name: RouteNames.signin,
      path: '/signin',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      name: RouteNames.signup,
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      name: RouteNames.dashboard,
      path: '/dashboard',
      builder: (context, state) => Dashboard(),
    ),
    GoRoute(
      name: RouteNames.home,
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: RouteNames.internetPackages,
      path: '/internetPackages',
      builder: (context, state) => AllPackagesPage(),
    ),
    GoRoute(
      name: RouteNames.detail,
      path: '/detail',
      builder: (context, state) {
        final package = state.extra as InternetPackageEntity;
        return DetailPage(internetPackage: package);
      },
    ),
  ],
);
