import 'package:fluffy_budget/core/database/converters/color_converter.dart';
import 'package:fluffy_budget/core/database/converters/icon_data_converter.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod extends ExpenseProperty {
  final int? id;
  final String label;
  @IconDataConverter()
  final IconData icon;
  @ColorConverter()
  final Color? color;

  const PaymentMethod({
    this.id,
    required this.label,
    required this.icon,
    this.color,
  }) : super(label: label, icon: icon, color: color);

  @override
  PropertyType get type => PropertyType.paymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}