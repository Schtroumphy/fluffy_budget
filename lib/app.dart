import 'package:fluffy_budget/core/environment.dart';
import 'package:fluffy_budget/core/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app.g.dart';

@Riverpod(keepAlive: true)
Environment environment(EnvironmentRef ref) => throw UnimplementedError("Environment provider must be overridden");

launchApp(Environment environment) {
  final container = ProviderContainer(
    overrides: [
      environmentProvider.overrideWithValue(environment),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.read(environmentProvider).appName;
    final router = ref.read(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: kDebugMode,
    );
  }
}