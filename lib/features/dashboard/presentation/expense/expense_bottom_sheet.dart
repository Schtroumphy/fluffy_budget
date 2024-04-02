import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:fluffy_budget/widgets/atoms/close_sheet_bar.dart';
import 'package:fluffy_budget/widgets/atoms/rounded_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> displayExpenseModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
    isDismissible: true,
    builder: (context) => const AddExpenseBottomSheet(),
  );
}

class AddExpenseBottomSheet extends StatelessWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CloseSheetBar(),
            gapV12,
            const DropDownRow(),
            gapV12,
            Text(
              "Expenses",
              style: theme.labelMedium?.copyWith(color: AppColor.black[40], fontStyle: FontStyle.italic),
            ),
            gapV12,
            const AmountTextField(),
          ],
        ),
      ),
    );
  }
}

class AmountTextField extends StatefulWidget {
  const AmountTextField({super.key});

  static final FocusNode textFieldFocusNode = FocusNode();

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenWidth * 0.5,
        child: TextField(
          focusNode: AmountTextField.textFieldFocusNode,
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            prefix: Icon(Icons.euro_rounded),
            hintText: '0.00',
          ),
          style: theme.bodyLarge?.copyWith(
            fontSize: Insets.i56,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          onSubmitted: (String value) {

          },
        ),
      ),
    );
  }
}

class DropDownRow extends ConsumerWidget {
  const DropDownRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: RoundedDropdown(itemType : ItemType.expenseCategory,)),
        gapH12,
        Flexible(child: RoundedDropdown(itemType: ItemType.paymentMethod,)),
      ],
    );
  }
}
