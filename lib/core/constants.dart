
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:flutter/material.dart';

const Set<Category> expenseCategories = {
  Category(
    label: "Courses",
    icon: Icons.shopping_basket_rounded,
    color: AppColor.yellow,
  ),
  Category(
    label: "Loisirs",
    icon: Icons.local_attraction,
    color: AppColor.purple,
  ),
  Category(
    label: "Restaurants",
    icon: Icons.restaurant,
    color: AppColor.blue,
  ),
  Category(
    label: "Voiture",
    icon: Icons.car_crash_sharp,
    color: AppColor.green,
  ),
  Category(
    label: "Autres",
    icon: Icons.question_mark,
    color: AppColor.purple,
  ),
};

const Set<PaymentMethod> paymentMethods = {
  PaymentMethod(
    label: "Cash",
    icon: Icons.attach_money_rounded,
    color: AppColor.yellow,
  ),
  PaymentMethod(
    label: "Credit card",
    icon: Icons.credit_card_rounded,
    color: AppColor.purple,
  ),
  PaymentMethod(
    label: "Lydia",
    icon: Icons.phone_iphone,
    color: AppColor.blue,
  ),
  PaymentMethod(
    label: "Paypal",
    icon: Icons.paypal_rounded,
    color: AppColor.green,
  ),
  PaymentMethod(
    label: "Other",
    icon: Icons.shopping_basket_rounded,
    color: AppColor.purple,
  ),
};