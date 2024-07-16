import 'package:fluffy_budget/features/expenses/application/expense_service.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_list_provider.g.dart';

@riverpod
Future<List<Expense>?> expenseList(ExpenseListRef ref) {
  return ref.watch(expenseServiceProvider).fetchAllExpenses();
}

@riverpod
Future<List<ExpenseModel>?> expenseModelList(ExpenseModelListRef ref) {
  final service = ref.read(expenseServiceProvider);
  return service.fetchAllExpenseModels();
}


