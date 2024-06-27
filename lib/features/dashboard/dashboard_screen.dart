import 'package:fluffy_budget/features/expenses/presentation/bottom_sheet_list/expandable_expenses_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static String location = "/home";

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text("My app", style: theme.bodyLarge),
          const Expanded(child: ExpendableBottomSheet()),
        ]),
      ),
    );
  }
}
