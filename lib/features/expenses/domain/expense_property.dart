import 'package:flutter/material.dart';

abstract class ExpenseProperty {
  final int? id;
  final String label;
  final IconData icon;
  final Color? color;
  final PropertyType type;

  const ExpenseProperty({this.id, required this.label, required this.icon, this.color, this.type = PropertyType.unknown});
}

enum PropertyType{
  category,
  paymentMethod,
  unknown,
}