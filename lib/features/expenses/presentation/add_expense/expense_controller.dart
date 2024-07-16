import 'package:fluffy_budget/features/expenses/application/expense_service.dart';
import 'package:fluffy_budget/features/expenses/data/expense_repository.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:fluffy_budget/features/expenses/presentation/bottom_sheet_list/expense_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_controller.g.dart';

final categoriesProvider = FutureProvider.autoDispose<List<Category>?>((ref) {
  return ref.watch(expenseServiceProvider).fetchAllCategories();
});

final paymentMethodsProvider = FutureProvider.autoDispose<List<ExpenseProperty>?>((ref) {
  return ref.watch(expenseServiceProvider).fetchAllPaymentMethod();
});

@riverpod
class ExpenseController extends _$ExpenseController {
  @override
  Expense build() {
    return Expense.init();
  }

  void setExpense([ExpenseModel? expense]) {
    state = state.copyWith(
      id: expense?.id,
      categoryId: expense?.category?.id,
      paymentId: expense?.paymentMethod?.id,
    );
  }

  void onPaymentMethodSelected(int paymentMethodId) {
    if (paymentMethodId == state.paymentId) return;

    state = state.copyWith(
      paymentId: paymentMethodId,
    );
  }

  void onCategorySelected(int categoryId) {
    if (categoryId == state.categoryId) return;

    state = state.copyWith(
      categoryId: categoryId,
    );
  }

  onSubmitted(double amount) async {
    if (amount == 0.0) return;

    state = state.copyWith(
      amount: amount,
    );
    await ref.read(expenseRepoProvider).save(state);
    ref.invalidate(expenseModelListProvider);
  }

  deleteById(int id) async {
    await ref.read(expenseRepoProvider).deleteById(id);
  }
}
