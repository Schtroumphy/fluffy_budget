import 'package:fluffy_budget/features/expenses/data/expense_repository_provider.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_service.g.dart';

@Riverpod(keepAlive: true)
ExpenseService expenseService(ExpenseServiceRef ref) {
  return ExpenseService(ref);
}

class ExpenseService {
  const ExpenseService(this.ref);

  final Ref ref;

  Future<List<Expense>?> fetchAllExpenses() async {
    return ref.read(expenseRepoProvider).getAllExpenses();
  }
}
