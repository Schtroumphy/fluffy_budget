import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static String location = "/home";

  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("My app"),
      ),
    );
  }
}