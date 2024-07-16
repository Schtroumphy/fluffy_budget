import 'package:fluffy_budget/core/database/converters/color_converter.dart';
import 'package:fluffy_budget/core/database/converters/icon_data_converter.dart';
import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends ExpenseProperty{
  const Category({
    super.id,
    required super.label,
    required super.icon,
    super.color,
  });

  @override
  PropertyType get type => PropertyType.category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}