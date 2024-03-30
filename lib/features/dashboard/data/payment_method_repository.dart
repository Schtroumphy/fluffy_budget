import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_method_repository.g.dart';

@Riverpod(keepAlive: true)
PaymentMethodRepository paymentMethodRepo(PaymentMethodRepoRef ref){
  return PaymentMethodRepository(PaymentMethod.items);
}

class PaymentMethodRepository {
  final Set<DropDownItem> items;

  const PaymentMethodRepository(this.items);

  Set<DropDownItem> get collection => items;
}