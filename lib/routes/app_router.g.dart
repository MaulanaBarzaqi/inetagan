// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $landingRoute,
  $signInRoute,
  $signUpRoute,
  $dashboardRoute,
  $detailRoute,
  $subscribeRoute,
  $detailSubscribeRoute,
  $successSubscribeRoute,
  $failedSubscribeRoute,
  $getSubscribeRoute,
];

RouteBase get $landingRoute =>
    GoRouteData.$route(path: '/', factory: $LandingRoute._fromState);

mixin $LandingRoute on GoRouteData {
  static LandingRoute _fromState(GoRouterState state) => const LandingRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute =>
    GoRouteData.$route(path: '/signin', factory: $SignInRoute._fromState);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  @override
  String get location => GoRouteData.$location('/signin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute =>
    GoRouteData.$route(path: '/signup', factory: $SignUpRoute._fromState);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dashboardRoute => GoRouteData.$route(
  path: '/dashboard',
  factory: $DashboardRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'home', factory: $HomeTabRoute._fromState),
    GoRouteData.$route(
      path: 'histories',
      factory: $HistoriesTabRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'internet-packages',
      factory: $InternetPackagesTabRoute._fromState,
    ),
    GoRouteData.$route(path: 'profile', factory: $ProfileTabRoute._fromState),
  ],
);

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location('/dashboard');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HomeTabRoute on GoRouteData {
  static HomeTabRoute _fromState(GoRouterState state) => const HomeTabRoute();

  @override
  String get location => GoRouteData.$location('/dashboard/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HistoriesTabRoute on GoRouteData {
  static HistoriesTabRoute _fromState(GoRouterState state) =>
      const HistoriesTabRoute();

  @override
  String get location => GoRouteData.$location('/dashboard/histories');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InternetPackagesTabRoute on GoRouteData {
  static InternetPackagesTabRoute _fromState(GoRouterState state) =>
      const InternetPackagesTabRoute();

  @override
  String get location => GoRouteData.$location('/dashboard/internet-packages');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileTabRoute on GoRouteData {
  static ProfileTabRoute _fromState(GoRouterState state) =>
      const ProfileTabRoute();

  @override
  String get location => GoRouteData.$location('/dashboard/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $detailRoute =>
    GoRouteData.$route(path: '/detail', factory: $DetailRoute._fromState);

mixin $DetailRoute on GoRouteData {
  static DetailRoute _fromState(GoRouterState state) =>
      DetailRoute($extra: state.extra as InternetPackageEntity);

  DetailRoute get _self => this as DetailRoute;

  @override
  String get location => GoRouteData.$location('/detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $subscribeRoute =>
    GoRouteData.$route(path: '/subscribe', factory: $SubscribeRoute._fromState);

mixin $SubscribeRoute on GoRouteData {
  static SubscribeRoute _fromState(GoRouterState state) =>
      SubscribeRoute($extra: state.extra as InternetPackageEntity);

  SubscribeRoute get _self => this as SubscribeRoute;

  @override
  String get location => GoRouteData.$location('/subscribe');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $detailSubscribeRoute => GoRouteData.$route(
  path: '/subscribe/detail',
  factory: $DetailSubscribeRoute._fromState,
);

mixin $DetailSubscribeRoute on GoRouteData {
  static DetailSubscribeRoute _fromState(GoRouterState state) =>
      DetailSubscribeRoute(
        name: state.uri.queryParameters['name']!,
        nik: state.uri.queryParameters['nik']!,
        phone: state.uri.queryParameters['phone']!,
        address: state.uri.queryParameters['address']!,
        $extra: state.extra as InternetPackageEntity,
      );

  DetailSubscribeRoute get _self => this as DetailSubscribeRoute;

  @override
  String get location => GoRouteData.$location(
    '/subscribe/detail',
    queryParams: {
      'name': _self.name,
      'nik': _self.nik,
      'phone': _self.phone,
      'address': _self.address,
    },
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $successSubscribeRoute => GoRouteData.$route(
  path: '/subscribe/success',
  factory: $SuccessSubscribeRoute._fromState,
);

mixin $SuccessSubscribeRoute on GoRouteData {
  static SuccessSubscribeRoute _fromState(GoRouterState state) =>
      const SuccessSubscribeRoute();

  @override
  String get location => GoRouteData.$location('/subscribe/success');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $failedSubscribeRoute => GoRouteData.$route(
  path: '/subscribe/failed',
  factory: $FailedSubscribeRoute._fromState,
);

mixin $FailedSubscribeRoute on GoRouteData {
  static FailedSubscribeRoute _fromState(GoRouterState state) =>
      const FailedSubscribeRoute();

  @override
  String get location => GoRouteData.$location('/subscribe/failed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $getSubscribeRoute => GoRouteData.$route(
  path: '/subscribe/get',
  factory: $GetSubscribeRoute._fromState,
);

mixin $GetSubscribeRoute on GoRouteData {
  static GetSubscribeRoute _fromState(GoRouterState state) =>
      const GetSubscribeRoute();

  @override
  String get location => GoRouteData.$location('/subscribe/get');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
