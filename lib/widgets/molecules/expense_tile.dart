import 'package:fluffy_budget/core/constants.dart';
import 'package:fluffy_budget/core/theme/app_theme.dart';
import 'package:fluffy_budget/widgets/space.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/widgets/atoms/rounded_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expenseModel, this.description});

  final ExpenseModel expenseModel;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.i4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.i18, vertical: Insets.i4),
        child: Row(
          key: UniqueKey(),
          children: [
            RoundedIcon(
              icon: expenseModel.category?.icon,
              color: expenseModel.category?.color,
            ),
            const HSpace(Insets.i6),
            Expanded(
                child: Text(
              description ?? StringConstants.noDescription,
              style: TextStyles.noDataGray,
            )),
            Text(
              "${expenseModel.amount}€",
              style: TextStyles.interM,
            )
          ],
        ),
      ),
    );
  }
}
