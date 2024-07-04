
import 'package:fluffy_budget/features/expenses/application/expense_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInit{

  static Future<void> setupData(ProviderContainer container) async {
    final expenseService = container.read(expenseServiceProvider);
    await expenseService.initExpenseAttributes();
  }

}