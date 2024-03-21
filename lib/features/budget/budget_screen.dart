import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetScreen extends StatelessWidget {
  static String location = "/screen2";

  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Screen 2"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
