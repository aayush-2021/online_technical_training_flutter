// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $detailsRoute,
      $details2Route,
      $bottomNavRoute,
    ];

RouteBase get $detailsRoute => GoRouteData.$route(
      path: '/detials',
      name: 'details',
      factory: $DetailsRouteExtension._fromState,
    );

extension $DetailsRouteExtension on DetailsRoute {
  static DetailsRoute _fromState(GoRouterState state) => DetailsRoute(
        name: state.uri.queryParameters['name']!,
      );

  String get location => GoRouteData.$location(
        '/detials',
        queryParams: {
          'name': name,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $details2Route => GoRouteData.$route(
      path: '/details2',
      name: 'details2',
      factory: $Details2RouteExtension._fromState,
    );

extension $Details2RouteExtension on Details2Route {
  static Details2Route _fromState(GoRouterState state) => Details2Route();

  String get location => GoRouteData.$location(
        '/details2',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bottomNavRoute => StatefulShellRouteData.$route(
      factory: $BottomNavRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              name: 'home',
              factory: $HomeRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/fav',
              name: 'fav',
              factory: $FavouritesRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/account',
              name: 'account',
              factory: $AccountRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $BottomNavRouteExtension on BottomNavRoute {
  static BottomNavRoute _fromState(GoRouterState state) =>
      const BottomNavRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FavouritesRouteExtension on FavouritesRoute {
  static FavouritesRoute _fromState(GoRouterState state) => FavouritesRoute();

  String get location => GoRouteData.$location(
        '/fav',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRouteExtension on AccountRoute {
  static AccountRoute _fromState(GoRouterState state) => AccountRoute();

  String get location => GoRouteData.$location(
        '/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
