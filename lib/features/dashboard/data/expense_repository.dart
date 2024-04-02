import 'package:fluffy_budget/features/dashboard/data/local/drop_down_dao.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository.g.dart';

@Riverpod(keepAlive: true)
ExpenseRepository expenseRepo(ExpenseRepoRef ref){
  return ExpenseRepository(ref, ExpenseCategory.items);
}

class ExpenseRepository {
  final Set<DropDownItem> items;
  final Ref ref;

  const ExpenseRepository(this.ref, this.items);

  Set<DropDownItem> get collection => items;

  Future<bool> isPaymentMethodEmpty() async {
    return await ref.read(dropDownDaoProvider).isEmpty(where: "type = ?", args: [ItemType.paymentMethod.code]);
  }

  Future<bool> isExpenseCategoryEmpty() async {
    return await ref.read(dropDownDaoProvider).isEmpty(where: "type = ?", args: [ItemType.expenseCategory.code]);
  }

  initPaymentMethodData() async {
    await ref.read(dropDownDaoProvider).saveAll(PaymentMethod.items);
  }

  initExpenseCategoryData() async {
    await ref.read(dropDownDaoProvider).saveAll(ExpenseCategory.items);
  }
}