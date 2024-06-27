import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(Insets.i12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.money),
      ),
    );
  }
}
