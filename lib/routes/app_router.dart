import 'package:flutter/material.dart';
import 'package:inetagan/features/features.dart';
import 'package:go_router/go_router.dart';
import '../features/internet-package/domain/entities/internet_package_entity.dart';

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

@TypedGoRoute<NotificationRoute>(path: '/notifications')
class NotificationRoute extends GoRouteData with $NotificationRoute {
  const NotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationsPage();
}

@TypedShellRoute<DashboardRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/home'),
    TypedGoRoute<HistoriesRoute>(path: '/histories'),
    TypedGoRoute<InternetPackagesRoute>(path: '/internet-package'),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
  ],
)
class DashboardRoute extends ShellRouteData {
  const DashboardRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return Dashboard(navigator: navigator);
  }
}

// Dashboard tab routes
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class HistoriesRoute extends GoRouteData with $HistoriesRoute {
  const HistoriesRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryPage();
}

class InternetPackagesRoute extends GoRouteData with $InternetPackagesRoute {
  const InternetPackagesRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AllPackagesPage();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: '/',
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Error: ${state.error}'))),
);
