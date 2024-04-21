import 'package:fluffy_budget/core/extensions/object_extension.dart';
import 'package:fluffy_budget/features/dashboard/data/drop_item_repository.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:fluffy_budget/features/expense/data/expense_repository.dart';
import 'package:fluffy_budget/features/expense/domain/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_expense_controller.g.dart';

@Riverpod()
Future<List<DropDownItem>?> itemsByType(ItemsByTypeRef ref, ItemType type) async {
  return await ref.read(dropItemRepoProvider).getItemsByType(type);
}

@riverpod
class AddExpenseController extends _$AddExpenseController {
  @override
  Expense build() {
    return Expense.init();
  }

  void onPaymentMethodSelected(int paymentMethodId) {
    state = state.copyWith(
      paymentId: paymentMethodId,
    );
  }

  void onCategorySelected(int categoryId) {
    state = state.copyWith(
        categoryId: categoryId,
    );
  }

  onAmountSubmitted(double amount) async {
    state = state.copyWith(
        amount: amount,
    );
    if(amount <= 0 || state.paymentId.isNull || state.paymentId.isNull) return;
    await ref.read(expenseRepoProvider).saveExpense(state);
  }

}


