import 'package:flutter/widgets.dart';
import 'package:inetagan/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/features/internet-package/domain/entities/internet_package_entity.dart';

part 'app_router.g.dart';

// auth routes (route level)
@TypedGoRoute<LandingRoute>(path: '/')
class LandingRoute extends GoRouteData with $LandingRoute {
  const LandingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LandingPage();
}

@TypedGoRoute<SignInRoute>(path: '/signin')
class SignInRoute extends GoRouteData with $SignInRoute {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<SignUpRoute>(path: '/signup')
class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

// main app - dashboard with nested routes
@TypedGoRoute<DashboardRoute>(
  path: '/dashboard',
  routes: [
    // dashboard tabs (bottom navigation)
    TypedGoRoute<HomeTabRoute>(path: 'home'),
    TypedGoRoute<HistoriesTabRoute>(path: 'histories'),
    TypedGoRoute<InternetPackagesTabRoute>(path: 'internet-packages'),
    TypedGoRoute<ProfileTabRoute>(path: 'profile'),
  ],
)
class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Dashboard();
  }
}

// dashboard tab routes
class HomeTabRoute extends GoRouteData with $HomeTabRoute {
  const HomeTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class HistoriesTabRoute extends GoRouteData with $HistoriesTabRoute {
  const HistoriesTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text("Histories"));
}

class InternetPackagesTabRoute extends GoRouteData
    with $InternetPackagesTabRoute {
  const InternetPackagesTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AllPackagesPage();
}

class ProfileTabRoute extends GoRouteData with $ProfileTabRoute {
  const ProfileTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

// package flow routes
@TypedGoRoute<DetailRoute>(path: '/detail')
class DetailRoute extends GoRouteData with $DetailRoute {
  const DetailRoute({required this.$extra});
  final InternetPackageEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final package = $extra;
    return DetailPage(internetPackage: package);
  }
}

@TypedGoRoute<SubscribeRoute>(path: '/subscribe')
class SubscribeRoute extends GoRouteData with $SubscribeRoute {
  const SubscribeRoute({required this.$extra});
  final InternetPackageEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final package = $extra;
    return SubscribePage(internetPackage: package);
  }
}

@TypedGoRoute<DetailSubscribeRoute>(path: '/subscribe/detail')
class DetailSubscribeRoute extends GoRouteData with $DetailSubscribeRoute {
  const DetailSubscribeRoute({
    required this.name,
    required this.nik,
    required this.phone,
    required this.address,
    required this.$extra,
  });
  final String name;
  final String nik;
  final String phone;
  final String address;
  final InternetPackageEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final InternetPackageEntity internetPackage = $extra;
    return DetailSubscribePage(
      internetPackage: internetPackage,
      name: name,
      nik: nik,
      phone: phone,
      address: address,
    );
  }
}

@TypedGoRoute<SuccessSubscribeRoute>(path: '/subscribe/success')
class SuccessSubscribeRoute extends GoRouteData with $SuccessSubscribeRoute {
  const SuccessSubscribeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SuccessSubscribePage();
}

@TypedGoRoute<FailedSubscribeRoute>(path: '/subscribe/failed')
class FailedSubscribeRoute extends GoRouteData with $FailedSubscribeRoute {
  const FailedSubscribeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FailedSubscribePage();
}

@TypedGoRoute<GetSubscribeRoute>(path: '/subscribe/get')
class GetSubscribeRoute extends GoRouteData with $GetSubscribeRoute {
  const GetSubscribeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GetSubscribePage();
}

final GoRouter router = GoRouter(routes: $appRoutes, initialLocation: '/');
