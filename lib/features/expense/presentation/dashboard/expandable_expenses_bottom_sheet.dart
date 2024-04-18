import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/features/expense/controllers/expense_controller.dart';
import 'package:fluffy_budget/widgets/molecules/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Source : https://medium.com/@tsung-wei_hsu/flutter-how-to-build-draggable-bottom-sheet-like-google-maps-1165f5b07366
///
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

  void _anchor() => _animateSheet(sheet.snapSizes!.last);

  void _expand() => _animateSheet(sheet.maxChildSize);

  void _hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DraggableScrollableSheet get sheet => (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseControllerProvider);

    return DraggableScrollableSheet(
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
            color: Colors.blue,
            boxShadow: [
              BoxShadow(color: Colors.black),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Insets.i14),
              topRight: Radius.circular(Insets.i14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Insets.i8),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: Text('TRANSACTIONS LIST'),
                ),
                const SliverToBoxAdapter(
                  child: VSpace(Insets.i8),
                ),
                expenses.when(
                    data: (data) => SliverList.builder(
                          itemBuilder: (BuildContext context, int index) {
                            if(data == null) return const SizedBox.shrink();
                            return ExpenseTile(expense: data[index],);
                          },
                        ),
                    error: (e, s) => const SliverToBoxAdapter(child: SizedBox.shrink()),
                    loading: () => const SliverToBoxAdapter(child: CircularProgressIndicator()))
              ],
            ),
          ),
        );
      },
    );
  }
}
