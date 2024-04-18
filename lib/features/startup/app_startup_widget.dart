import 'package:fluffy_budget/app.dart';
import 'package:fluffy_budget/core/extensions/duration_extension.dart';
import 'package:fluffy_budget/features/expense/data/drop_item_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_widget.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  // all asynchronous app initialization code should belong here:

  // Save category & payment methods in database if empty
  await setupData(ref);
}

Future<void> setupData(Ref ref) async {
// Add payment method & category expenses if not exists
  final itemRepo = ref.read(dropItemRepoProvider);
  final payMethodEmpty = await itemRepo.isPaymentMethodEmpty();

  if (payMethodEmpty) await itemRepo.initPaymentMethodData();

  final expenseCategoryEmpty = await itemRepo.isExpenseCategoryEmpty();
  if (expenseCategoryEmpty) await itemRepo.initExpenseCategoryData();

  await Future.delayed(2.seconds);

  if (kDebugMode) {
    print("Payment method is empty ? $payMethodEmpty");
    print("Expense category is empty ? $expenseCategoryEmpty");
  }
}

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key});

  @override
  ConsumerState<AppStartupWidget> createState() => _AppStartupWidgetState();
}

class _AppStartupWidgetState extends ConsumerState<AppStartupWidget> {
  @override
  void initState() {
    // handle async initialization
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 2. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      data: (_) => const MyApp(),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message ?? ""),
      ),
    );
  }
}
