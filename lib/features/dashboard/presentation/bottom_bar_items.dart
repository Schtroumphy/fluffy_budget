import 'package:fluffy_budget/features/budget/budget_screen.dart';
import 'package:fluffy_budget/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_bar_items.g.dart';

@Riverpod(keepAlive: true)
List<BottomBarItem> bottomBarItems(BottomBarItemsRef ref) {
  return _items;
}

final _items = <BottomBarItem>[
  BottomBarItem(
    icon: Icons.home,
    label: 'Home',
    location: DashboardScreen.location,
  ),
  BottomBarItem(
    icon: Icons.calendar_month,
    label: 'Calendar',
    location: DashboardScreen.location,
  ),
  BottomBarItem(
    icon: Icons.wallet,
    label: 'Budget',
    location: BudgetScreen.location,
  ),
  BottomBarItem(
    icon: Icons.person,
    label: 'Profile',
    location: DashboardScreen.location,
  ),
];

class BottomBarItem {
  final Key? key;
  final String label;
  final IconData icon;
  final String location;

  BottomBarItem({this.key, required this.label, required this.icon, required this.location});
}