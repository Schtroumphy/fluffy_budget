import 'package:fluffy_budget/features/expense/data/expense_repository.dart';
import 'package:fluffy_budget/features/expense/domain/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_controller.g.dart';

@riverpod
class ExpenseController extends _$ExpenseController {
  @override
  Future<List<Expense>?> build() {
    return Future.value(null);
  }

  Future<void> getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_process);
  }

  Future<List<Expense>?> _process() async {
    return await ref.read(expenseRepoProvider).getAllExpenses();
  }

}


