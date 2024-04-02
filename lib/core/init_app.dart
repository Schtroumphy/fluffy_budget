
import 'package:fluffy_budget/features/dashboard/data/expense_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInit{

  static Future<void> setupData(ProviderContainer container) async {

    // ADd payment method & category expenses if not exists
    final payMethodEmpty = await container.read(expenseRepoProvider).isPaymentMethodEmpty();
    if(payMethodEmpty) {
      await container.read(expenseRepoProvider).initPaymentMethodData();
    }

    final expenseCategoryEmpty = await container.read(expenseRepoProvider).isExpenseCategoryEmpty();
    if(expenseCategoryEmpty) {
      await container.read(expenseRepoProvider).initExpenseCategoryData();
    }

    if(kDebugMode)  {
      print("Payment method is empty ? $payMethodEmpty");
      print("Expense category is empty ? $expenseCategoryEmpty");
    }
  }
}