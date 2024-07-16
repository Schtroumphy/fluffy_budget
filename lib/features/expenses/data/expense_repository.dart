import 'package:fluffy_budget/features/expenses/data/local/expense_dao.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository.g.dart';

@Riverpod(keepAlive: true)
ExpenseRepository expenseRepo(ExpenseRepoRef ref){
  return ExpenseRepository(ref);
}

class ExpenseRepository {
  final Ref ref;

  const ExpenseRepository(this.ref);

  Future<void> save(Expense expense) async {
    return await ref.read(expenseDaoProvider).save(expense);
  }

  Future<List<Expense>?> getAll() async {
    final expenseDao = ref.watch(expenseDaoProvider);
    return (await expenseDao.getAll());
  }

  Future<void> deleteById(int id) async {
    return await ref.read(expenseDaoProvider).delete('id = ?', ['$id']);
  }
}