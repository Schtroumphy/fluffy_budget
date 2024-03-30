import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static String location = "/home";

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Text("My app", style: theme.bodyLarge)
      ),
    );
  }
}
