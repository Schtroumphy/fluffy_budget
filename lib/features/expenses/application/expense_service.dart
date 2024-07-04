import 'package:fluffy_budget/features/expenses/data/category_repository.dart';
import 'package:fluffy_budget/features/expenses/data/expense_repository.dart';
import 'package:fluffy_budget/features/expenses/data/payment_method_repository.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_service.g.dart';

@Riverpod(keepAlive: true)
ExpenseService expenseService(ExpenseServiceRef ref) {
  return ExpenseService(ref);
}

class ExpenseService {
  const ExpenseService(this.ref);

  final Ref ref;

  Future<List<ExpenseProperty>?> fetchAllCategories() async {
    return ref.read(categoryRepoProvider).getAll();
  }

  Future<List<ExpenseProperty>?> fetchAllPaymentMethod() async {
    final res = ref.read(paymentMethodRepoProvider).getAll();
    return res;
  }

  Future<List<Expense>?> fetchAllExpenses() async {
    return ref.read(expenseRepoProvider).getAll();
  }

  // Init categories & payment method if tables empties
  Future<void> initExpenseAttributes() async {
    final categoryRepository = ref.read(categoryRepoProvider);
    final paymentMethodRepository = ref.read(paymentMethodRepoProvider);

    final isPayMethodEmpty = await paymentMethodRepository.isEmpty();
    if(isPayMethodEmpty) await paymentMethodRepository.initPaymentMethodData();

    final isCategoryEmpty = await categoryRepository.isEmpty();
    if(isCategoryEmpty) await categoryRepository.initCategoryData();

    if(kDebugMode)  {
      print("Payment method is empty ? $isPayMethodEmpty");
      print("Expense category is empty ? $isCategoryEmpty");
    }
  }
}
