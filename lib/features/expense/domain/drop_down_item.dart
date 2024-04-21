import 'package:fluffy_budget/core/converters/color_converter.dart';
import 'package:fluffy_budget/core/converters/icon_data_converter.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_down_item.g.dart';

@JsonSerializable()
class DropDownItem {
  final int? id;
  final String label;
  @IconDataConverter()
  final IconData icon;
  @ColorConverter()
  final Color? color;
  final String type;

  const DropDownItem({this.id, required this.label, required this.icon, this.color, required this.type});

  factory DropDownItem.fromJson(Map<String, dynamic> json) => _$DropDownItemFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DropDownItemToJson(this);
}

enum ItemType {
  paymentMethod("PAY_MET", "Paiement"),
  expenseCategory("EXP_CAT", "Catégorie");

  const ItemType(this.code, this.description);

  final String code;
  final String description;
}

enum PaymentMethod {
  cash(label: "Cash", icon: Icons.attach_money_rounded, color: AppColor.yellow),
  creditCard(label: "Credit card", icon: Icons.credit_card_rounded, color: AppColor.purple),
  lydia(label: "Lydia", icon: Icons.phone_iphone, color: AppColor.blue),
  paypal(label: "Paypal", icon: Icons.paypal_rounded, color: AppColor.green),
  other(label: "Other", icon: Icons.shopping_basket_rounded, color: AppColor.purple);

  final String label;
  final IconData icon;
  final Color? color;

  const PaymentMethod({required this.label, required this.icon, this.color});

  static Set<DropDownItem> get items => values.map((e) => DropDownItem(label: e.label, icon: e.icon, color: e.color, type: ItemType.paymentMethod.code)).toSet();
}

enum ExpenseCategory {
  groceries(label: "Courses", icon: Icons.shopping_basket_rounded, color: AppColor.yellow),
  fun(label: "Loisirs", icon: Icons.local_attraction, color: AppColor.purple),
  restaurant(label: "Restaurants", icon: Icons.restaurant, color: AppColor.blue),
  car(label: "Voiture", icon: Icons.car_crash_sharp, color: AppColor.green),
  other(label: "Autres", icon: Icons.question_mark, color: AppColor.purple);

  final String label;
  final IconData icon;
  final Color? color;

  const ExpenseCategory({required this.label, required this.icon, this.color});

  static Set<DropDownItem> get items => values.map((e) => DropDownItem(label: e.label, icon: e.icon, color: e.color, type: ItemType.expenseCategory.code)).toSet();
}
