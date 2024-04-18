import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/features/expense/domain/expense.dart';
import 'package:fluffy_budget/widgets/atoms/rounded_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: UniqueKey(),
      children: [
        const RoundedIcon(),
        const HSpace(Insets.i6),
        const Expanded(child: Text("MA DEPENSE")),
        Text(expense.amount.toString())
      ],
    );
  }
}
