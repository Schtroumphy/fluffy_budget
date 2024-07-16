import 'package:fluffy_budget/core/constants.dart';
import 'package:fluffy_budget/features/expenses/presentation/add_expense/add_expense_bottom_sheet.dart';
import 'package:fluffy_budget/features/expenses/presentation/bottom_sheet_list/expense_list_provider.dart';
import 'package:fluffy_budget/router/router.dart';
import 'package:fluffy_budget/widgets/molecules/expense_tile.dart';
import 'package:fluffy_budget/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpendableBottomSheet extends ConsumerStatefulWidget {
  const ExpendableBottomSheet({super.key});

  @override
  ConsumerState<ExpendableBottomSheet> createState() => _ExpendableBottomSheetState();
}

class _ExpendableBottomSheetState extends ConsumerState<ExpendableBottomSheet> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController(); // Important ! Without, the sheet will scroll but not drag at all

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.05) _collapse();
  }

  void _collapse() => _animateSheet(sheet.snapSizes!.first);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  DraggableScrollableSheet get sheet => //
      (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    final expenseModels = ref.watch(expenseModelListProvider);

    return Scaffold(
      body: DraggableScrollableSheet(
        key: _sheet,
        initialChildSize: 0.5,
        maxChildSize: 1,
        minChildSize: 0.5,
        snap: true,
        snapSizes: const [0.5],
        controller: _controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                        child: Text(
                      StringConstants.lastTransactions.toUpperCase(),
                    )),
                  ),
                  const SliverToBoxAdapter(
                    child: VSpace(28),
                  ),
                  expenseModels.when(
                    data: (data) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (data == null || data.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          final expense = data[index];

                          return InkWell(
                            onTap: () {
                              ref.read(displayFabButtonNotifierProvider.notifier).hideFab();
                              displayAddExpenseModal(context, expense: expense, ref: ref);
                            },
                            child: ExpenseTile(expenseModel: expense),
                          );
                        },
                        childCount: data?.length ?? 0,
                      ),
                    ),
                    error: (e, s) => const SliverToBoxAdapter(child: SizedBox.shrink()),
                    loading: () => const SliverToBoxAdapter(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
