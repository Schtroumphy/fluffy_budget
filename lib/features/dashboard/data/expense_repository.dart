import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository.g.dart';

@Riverpod(keepAlive: true)
ExpenseRepository expenseRepo(ExpenseRepoRef ref){
  return ExpenseRepository(ExpenseCategory.items);
}

class ExpenseRepository {
  final Set<DropDownItem> items;

  const ExpenseRepository(this.items);

  Set<DropDownItem> get collection => items;
}