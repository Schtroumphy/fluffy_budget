
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment.g.dart';

@Riverpod(keepAlive: true)
Environment environment(EnvironmentRef ref) => throw UnimplementedError("Environment provider must be overridden");


class Environment {
  final String name;
  final String appName;

  const Environment(this.name, this.appName);
}

