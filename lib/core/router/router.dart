import 'package:fluffy_budget/app.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return _router;
}

final _routes = <RouteBase>[
  GoRoute(
    path: HomePage.location,
    builder: (_, __) => const HomePage(),
  ),
  GoRoute(
    path: Screen2.location,
    builder: (_, __) => const Screen2(),
  ),
];

final GoRouter _router = GoRouter(
  routes: _routes,
  initialLocation: HomePage.location,
);
