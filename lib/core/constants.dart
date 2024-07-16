
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:flutter/material.dart';

class StringConstants {

  static const noDescription = "No description";
  static const categoryText = "Category";
  static const paymentMethodText = "Payment Method";
  static const expensesText = "Expenses";
  static const addExpenseHint = "0.00";
  static const lastTransactions ="Dernières transactions";

}

Set<Category> expenseCategories = {
  const Category(
    label: "Courses",
    icon: Icons.shopping_basket_rounded,
    color: AppColor.yellow,
  ),
  const Category(
    label: "Loisirs",
    icon: Icons.local_attraction,
    color: AppColor.purple,
  ),
  const Category(
    label: "Restaurants",
    icon: Icons.restaurant,
    color: AppColor.blue,
  ),
  const Category(
    label: "Voiture",
    icon: Icons.car_crash_sharp,
    color: AppColor.green,
  ),
  const Category(
    label: "Autres",
    icon: Icons.question_mark,
    color: AppColor.purple,
  ),
};

Set<PaymentMethod> paymentMethods = {
  const PaymentMethod(
    label: "Cash",
    icon: Icons.attach_money_rounded,
    color: AppColor.yellow,
  ),
  const PaymentMethod(
    label: "Credit card",
    icon: Icons.credit_card_rounded,
    color: AppColor.purple,
  ),
  const PaymentMethod(
    label: "Lydia",
    icon: Icons.phone_iphone,
    color: AppColor.blue,
  ),
  const PaymentMethod(
    label: "Paypal",
    icon: Icons.paypal_rounded,
    color: AppColor.green,
  ),
  const PaymentMethod(
    label: "Other",
    icon: Icons.shopping_basket_rounded,
    color: AppColor.purple,
  ),
};
