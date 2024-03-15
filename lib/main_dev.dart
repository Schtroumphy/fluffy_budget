import 'package:fluffy_budget/core/environment.dart';

import 'app.dart';

const _env = Environment(
  "DEV",
  "[DEV] Fluffy Budget",
);

void main() {
  launchApp(_env);
}
