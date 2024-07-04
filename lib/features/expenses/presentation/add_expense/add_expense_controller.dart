import 'package:fluffy_budget/core/extensions/object_extension.dart';
import 'package:fluffy_budget/features/expenses/application/expense_service.dart';
import 'package:fluffy_budget/features/expenses/data/expense_repository.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:fluffy_budget/features/expenses/presentation/bottom_sheet_list/expense_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_expense_controller.g.dart';

final categoriesProvider = FutureProvider.autoDispose<List<ExpenseProperty>?>((ref) {
  return ref.watch(expenseServiceProvider).fetchAllCategories();
});

final paymentMethodsProvider = FutureProvider.autoDispose<List<ExpenseProperty>?>((ref) {
  return ref.watch(expenseServiceProvider).fetchAllPaymentMethod();
});

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
    await ref.read(expenseRepoProvider).save(state);
    ref.invalidate(expenseListProvider);
  }

}


