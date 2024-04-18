import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expandable_expenses_bottom_sheet.dart';

class DashboardScreen extends StatelessWidget {
  static String location = "/home";

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("DASHBOARD IN WORK IN PROGRESS"),
            Expanded(child: ExpendableBottomSheet()),
          ],
        ),
      ),
    );
  }
}
