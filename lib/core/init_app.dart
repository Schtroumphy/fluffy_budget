
import 'package:fluffy_budget/features/expense/data/drop_item_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInit{

  static Future<void> setupData(ProviderContainer container) async {

    // ADd payment method & category expenses if not exists
    final itemRepo = container.read(dropItemRepoProvider);
    final payMethodEmpty = await itemRepo.isPaymentMethodEmpty();

    if(payMethodEmpty) await itemRepo.initPaymentMethodData();

    final expenseCategoryEmpty = await itemRepo.isExpenseCategoryEmpty();
    if(expenseCategoryEmpty) await itemRepo.initExpenseCategoryData();

    if(kDebugMode)  {
      print("Payment method is empty ? $payMethodEmpty");
      print("Expense category is empty ? $expenseCategoryEmpty");
    }
  }
}