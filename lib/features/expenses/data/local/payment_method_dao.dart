import 'package:fluffy_budget/core/database/dao.dart';
import 'package:fluffy_budget/core/database/database_notifier.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'payment_method_dao.g.dart';

@Riverpod(keepAlive: true)
PaymentMethodDao paymentMethodDao(PaymentMethodDaoRef ref) {
  return PaymentMethodDao(ref);
}

class PaymentMethodDao extends Dao<PaymentMethod> {
  PaymentMethodDao(this.ref) : super(tableName: "payment_method");

  final Ref ref;

  @override
  Future<Database> get database => ref.read(databaseNotifierProvider.future);

  @override
  Map<String, dynamic> toEntity(PaymentMethod model) {
    return model.toJson();
  }

  @override
  PaymentMethod toModel(Map<String, dynamic> entity) {
    return PaymentMethod.fromJson(entity);
  }
}