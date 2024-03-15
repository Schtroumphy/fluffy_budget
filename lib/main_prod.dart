import 'package:fluffy_budget/core/environment.dart';

import 'app.dart';

const _env = Environment(
  "PROD",
  "Fluffy Budget",
);

void main() {
  launchApp(_env);
}
