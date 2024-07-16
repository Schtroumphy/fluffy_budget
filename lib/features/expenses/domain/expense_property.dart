import 'package:fluffy_budget/core/database/converters/color_converter.dart';
import 'package:fluffy_budget/core/database/converters/icon_data_converter.dart';
import 'package:flutter/material.dart';

abstract class ExpenseProperty {
  final int? id;
  final String label;
  @IconDataConverter()
  final IconData icon;
  @ColorConverter()
  final Color? color;
  final PropertyType type;

  const ExpenseProperty({this.id, required this.label, required this.icon, this.color, this.type = PropertyType.unknown});

  (int?, String) _equality() => (id, label);

  @override
  int get hashCode => _equality().hashCode;

  @override
  String toString() {
    return "id: $id, label: $label";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if(other is! ExpenseProperty) return false;

    return _equality() == other._equality();
  }
}

enum PropertyType{
  category,
  paymentMethod,
  unknown,
}