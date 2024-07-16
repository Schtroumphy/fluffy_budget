import 'package:fluffy_budget/features/expenses/data/category_repository.dart';
import 'package:fluffy_budget/features/expenses/data/expense_repository.dart';
import 'package:fluffy_budget/features/expenses/data/payment_method_repository.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart' as domain;
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
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

  Future<List<domain.Category>?> fetchAllCategories() async => //
      ref.read(categoryRepoProvider).getAll();

  Future<List<PaymentMethod>?> fetchAllPaymentMethod() async => //
      ref.read(paymentMethodRepoProvider).getAll();

  Future<List<Expense>?> fetchAllExpenses() async {
    return ref.read(expenseRepoProvider).getAll();
  }

  Future<List<ExpenseModel>?> fetchAllExpenseModels() async {
    final expenses = await ref.read(expenseRepoProvider).getAll();
    final categories = await ref.read(categoryRepoProvider).getAll();
    final methods = await ref.read(paymentMethodRepoProvider).getAll();

    try {
      final res = expenses
          ?.map((e) => ExpenseModel(
                id: e.id,
                amount: e.amount,
                category: e.categoryId == null ? null : categories?.firstWhere((c) => c.id == e.categoryId),
                paymentMethod: e.paymentId == null ? null : methods?.firstWhere((c) => c.id == e.paymentId),
              ))
          .toList();
      return res;
    } catch (e) {
      return null;
    }
  }

  // Init categories & payment method if tables empties
  Future<void> initExpenseAttributes() async {
    final categoryRepository = ref.read(categoryRepoProvider);
    final paymentMethodRepository = ref.read(paymentMethodRepoProvider);

    final isPayMethodEmpty = await paymentMethodRepository.isEmpty();
    if (isPayMethodEmpty) await paymentMethodRepository.initPaymentMethodData();

    final isCategoryEmpty = await categoryRepository.isEmpty();
    if (isCategoryEmpty) await categoryRepository.initCategoryData();

    if (kDebugMode) {
      print("Payment method is empty ? $isPayMethodEmpty");
      print("Expense category is empty ? $isCategoryEmpty");
    }
  }
}
