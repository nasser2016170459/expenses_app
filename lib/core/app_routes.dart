import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inovola/core/components/app_navigation_scaffold/app_navigation_scaffold.dart';
import 'package:inovola/features/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();
  static const String home = "/";
  static const String dummy1 = "/dummy1";
  static const String dummy2 = "/dummy2";
  static const String dummy3 = "/dummy3";
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppNavigationScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: home,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context,
                state,
                const HomeScreen(),
              );
            },
          ),
          GoRoute(
            path: dummy1,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context,
                state,
                const SizedBox(),
              );
            },
          ),
          GoRoute(
            path: dummy2,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context,
                state,
                const SizedBox(),
              );
            },
          ),
          GoRoute(
            path: dummy3,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context,
                state,
                const SizedBox(),
              );
            },
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage buildPageWithDefaultTransition<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(seconds: 0),
      reverseTransitionDuration: const Duration(seconds: 0),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeAnimation =
            Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }
}
