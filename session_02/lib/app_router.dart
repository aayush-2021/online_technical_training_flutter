import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:session_02/account_screen.dart';
import 'package:session_02/bottom_nav_screen.dart';
import 'package:session_02/favourite_screen.dart';
import 'package:session_02/main.dart';

part 'app_router.g.dart';

final router = GoRouter(
  // navigatorKey: ,
  // errorBuilder: ,
  initialLocation: '/home',
  routes: $appRoutes,
);

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(
        child: HomeScreen(),
      );
}

@TypedGoRoute<DetailsRoute>(
  path: '/detials',
  name: 'details',
)
class DetailsRoute extends GoRouteData {
  final String name;
  DetailsRoute({required this.name});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailsScreen(name: name);
  }
}

@TypedGoRoute<Details2Route>(
  path: '/details2',
  name: 'details2',
)
class Details2Route extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DetailsScreen2();
  }
}

@TypedStatefulShellRoute<BottomNavRoute>(
  branches: [
    /// Home Shell Branch
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/home',
          name: 'home',
        ),
      ],
    ),

    /// Favoruite Shell Branch
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<FavouritesRoute>(
          path: '/fav',
          name: 'fav',
        ),
      ],
    ),

    /// Account Shell Branch
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<AccountRoute>(
          path: '/account',
          name: 'account',
        ),
      ],
    ),
  ],
)
class BottomNavRoute extends StatefulShellRouteData {
  const BottomNavRoute();
  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return NoTransitionPage(
      child: BottomNavScreen(
        key: state.pageKey,
        child: navigationShell,
      ),
    );
  }
}

class FavouritesRoute extends GoRouteData {
  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: FavouriteScreen());
  }
}

class AccountRoute extends GoRouteData {
  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: AccountScreen());
  }
}







// deeplink -> opening our application from another application
