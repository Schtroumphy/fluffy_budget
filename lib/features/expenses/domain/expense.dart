import 'package:fluffy_budget/core/database/converters/date_time_converter.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final int id;
  final double amount;
  final int? categoryId;
  final int? paymentId;
  @DateTimeConverter()
  final DateTime? date;

  const Expense({this.id = -1, required this.amount, this.categoryId, this.paymentId, this.date});

  Expense.init()
      : id = -1,
        amount = 0,
        date = DateTime.now(),
        categoryId = null,
        paymentId = null;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Expense copyWith({
    int? id,
    double? amount,
    int? categoryId,
    int? paymentId,
    DateTime? date,
  }) {
    return Expense(
      id : id ?? this.id,
      amount : amount ?? this.amount,
      categoryId : categoryId ?? this.categoryId,
      paymentId : paymentId ?? this.paymentId,
      date : date ?? this.date ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return "Expense (amount: $amount, categoryCode: $categoryId, paymentCode: $paymentId)";
  }
}

class ExpenseModel {
  final int id;
  final double amount;
  final DateTime? date;
  final Category? category;
  final PaymentMethod? paymentMethod;

  ExpenseModel({required this.id, required this.amount, this.category, this.paymentMethod, this.date});
}