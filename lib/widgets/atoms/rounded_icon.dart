import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({super.key, this.color, this.icon});

  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(Insets.i12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.i8),
        child: Icon(icon ?? Icons.money),
      ),
    );
  }
}
