import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'bottom_bar_items.dart';

class ShellScaffold extends ConsumerWidget {
  const ShellScaffold({super.key, required this.items, required this.body});

  final List<BottomBarItem> items;
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomBar(
        items: items,
        onTap: (item) => _onTap(context, item),
        currentIndex: _currentIndex(context),
        hasFloatingButton: true,
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final String location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    final index = items.indexWhere((item) => location.startsWith(item.location));
    return index < 0 ? 0 : index;
  }

  void _onTap(BuildContext context, BottomBarItem item) {
    context.go(item.location);
  }
}

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.hasFloatingButton = true,
  });

  final List<BottomBarItem> items;
  final ValueChanged<BottomBarItem>? onTap;
  final int currentIndex;
  final bool hasFloatingButton;

  int get length {
    return items.length + 1;
  }

  int get actionIndex {
    return length ~/ 2;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(length, _buildItem),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    if (actionIndex == index) {
      return SizedBox(width: hasFloatingButton ? 56 : 0);
    }

    final itemIndex = index - (index >= actionIndex ? 1 : 0);
    final item = items[itemIndex];

    return Expanded(
      child: AppBottomIcon(
        key: item.key,
        icon: item.icon,
        onTap: () => onTap?.call(item),
        active: currentIndex == itemIndex,
      ),
    );
  }
}

class AppBottomIcon extends StatelessWidget {
  const AppBottomIcon({
    super.key,
    required this.icon,
    required this.onTap,
    required this.active,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final size = IconTheme.of(context).size;
    final theme = Theme.of(context);

    return InkResponse(
      onTap: onTap,
      child: Center(
        child: Icon(
          icon,
          size: size,
          color: active ? theme.primaryColor : theme.disabledColor,
        ),
      ),
    );
  }
}
