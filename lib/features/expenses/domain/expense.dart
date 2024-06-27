import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final int id;
  final double amount;
  final int? categoryId;
  final int? paymentId;

  const Expense({this.id = -1, required this.amount, this.categoryId, this.paymentId});

  Expense.init()
      : id = -1,
        amount = 0,
        categoryId = null,
        paymentId = null;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Expense copyWith({
    int? id,
    double? amount,
    int? categoryId,
    int? paymentId,
  }) {
    return Expense(
      id : id ?? this.id,
      amount : amount ?? this.amount,
      categoryId : categoryId ?? this.categoryId,
      paymentId : paymentId ?? this.paymentId,
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
  final int? categoryIconCodePoint;
  final int? paymentIconCodePoint;

  ExpenseModel(this.id, this.amount, this.categoryIconCodePoint, this.paymentIconCodePoint);
}