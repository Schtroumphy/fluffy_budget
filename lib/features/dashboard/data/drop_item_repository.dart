import 'package:fluffy_budget/features/dashboard/data/local/drop_down_dao.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drop_item_repository.g.dart';

@Riverpod(keepAlive: true)
DropItemRepository dropItemRepo(DropItemRepoRef ref){
  return DropItemRepository(ref, ExpenseCategory.items);
}

class DropItemRepository {
  final Set<DropDownItem> items;
  final Ref ref;

  const DropItemRepository(this.ref, this.items);

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

  Future<List<DropDownItem>?> getItemsByType(ItemType type) async {
    return (await ref.read(dropDownDaoProvider).queryItems(where: "type = ?", args: [type.code]));
  }
}