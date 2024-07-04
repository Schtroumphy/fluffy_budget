import 'package:fluffy_budget/core/constants.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local/payment_method_dao.dart';

part 'payment_method_repository.g.dart';

@Riverpod(keepAlive: true)
PaymentMethodRepository paymentMethodRepo(PaymentMethodRepoRef ref){
  return PaymentMethodRepository(ref, paymentMethods);
}

class PaymentMethodRepository {
  final Ref ref;
  final Set<PaymentMethod> items;

  const PaymentMethodRepository(this.ref, this.items);

  Set<PaymentMethod> get collection => items;


  Future<bool> isEmpty() async {
    return await ref.read(paymentMethodDaoProvider).isEmpty();
  }

  initPaymentMethodData() async {
    await ref.read(paymentMethodDaoProvider).saveAll(paymentMethods);
  }

  Future<List<ExpenseProperty>?> getAll() async {
    final paymentMethodDao = ref.read(paymentMethodDaoProvider);
    final res = (await paymentMethodDao.getAll());
    return res  as List<ExpenseProperty>;
  }
}