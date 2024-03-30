import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class DropDownItem {
  final String label;
  final IconData icon;
  final Color? color;

  const DropDownItem({required this.label, required this.icon, this.color});
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

  static Set<DropDownItem> get items => values.map((e) => DropDownItem(label: e.label, icon: e.icon, color: e.color)).toSet();
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

  static Set<DropDownItem> get items => values.map((e) => DropDownItem(label: e.label, icon: e.icon, color: e.color)).toSet();
}
