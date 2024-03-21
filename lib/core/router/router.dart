import 'package:fluffy_budget/core/extensions/build_context_extensions.dart';
import 'package:fluffy_budget/features/budget/budget_screen.dart';
import 'package:fluffy_budget/features/dashboard/presentation/ScaffoldShellRoute.dart';
import 'package:fluffy_budget/features/dashboard/presentation/bottom_bar_items.dart';
import 'package:fluffy_budget/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return _router;
}

final _routes = <RouteBase>[
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, _, child) {
      return ShellScaffold(
        items: context.read(bottomBarItemsProvider),
        body: child,
      );
    },
    routes: [
      GoRoute(
        path: DashboardScreen.location,
        builder: (_, __) => const DashboardScreen(),
      ),
      GoRoute(
        path: BudgetScreen.location,
        builder: (_, __) => const BudgetScreen(),
      ),
    ],
  ),
];

final GoRouter _router = GoRouter(
  routes: _routes,
  initialLocation: DashboardScreen.location,
);
