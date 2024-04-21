import 'package:fluffy_budget/features/expense/data/local/expense_dao.dart';
import 'package:fluffy_budget/features/expense/domain/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository_provider.g.dart';

@riverpod
ExpenseRepository expenseRepo(ExpenseRepoRef ref){
  return ExpenseRepository(ref);
}

class ExpenseRepository {
  final Ref ref;

  const ExpenseRepository(this.ref);

  Future<void> saveExpense(Expense expense) async {
    return await ref.read(expenseDaoProvider).save(expense);
  }

  Future<List<Expense>?> getAllExpenses() async {
    return await ref.watch(expenseDaoProvider).getAll();
  }
}