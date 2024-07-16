import 'package:fluffy_budget/core/extensions/duration_extensions.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:fluffy_budget/features/expenses/domain/payment_method.dart';
import 'package:fluffy_budget/features/expenses/presentation/add_expense/add_expense_controller.dart';
import 'package:fluffy_budget/router/router.dart';
import 'package:fluffy_budget/widgets/async_value_widget.dart';
import 'package:fluffy_budget/widgets/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/widgets/atoms/close_sheet_bar.dart';
import 'package:fluffy_budget/widgets/atoms/rounded_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> displayAddExpenseModal(BuildContext context, {ExpenseModel? expense, WidgetRef? ref}) async {
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
    isDismissible: true,
    builder: (context) => AddExpenseBottomSheet(expense: expense),
  ).then((value) async {
    if (value == null) {
      // Modal closed by clicking outside
      ref?.invalidate(displayFabButtonNotifierProvider);
    }
  });
}

class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  const AddExpenseBottomSheet({super.key, this.expense});

  final ExpenseModel? expense;

  @override
  ConsumerState<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends ConsumerState<AddExpenseBottomSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(0.seconds, () => //
        ref.read(addExpenseControllerProvider.notifier).setExpense(widget.expense));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final controller = ref.read(addExpenseControllerProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CloseSheetBar(),
            gapV12,
            DropDownRow(
              initialCategory: widget.expense?.category,
              onCategorySelected: (id) => controller.onCategorySelected(id),
              initialPaymentMethod: widget.expense?.paymentMethod,
              onPaymentSelected: (id) => controller.onPaymentMethodSelected(id),
            ),
            gapV12,
            Text(
              "Expenses",
              style: theme.labelMedium?.copyWith(color: AppColor.black[40], fontStyle: FontStyle.italic),
            ),
            gapV12,
            AmountTextField(initialValue: widget.expense?.amount, onSubmit: (amount) => _onSubmit(amount, controller, context)),
          ],
        ),
      ),
    );
  }

  _onSubmit(String amount, AddExpenseController controller, BuildContext context) {
    final amountParsed = double.tryParse(amount.replaceAll(",", "."));
    if (amountParsed == null) {
      return;
    }
    controller.onSubmitted(amountParsed);

    if (!context.mounted) return;

    Navigator.of(context).pop();
  }
}

class AmountTextField extends ConsumerStatefulWidget {
  static final FocusNode textFieldFocusNode = FocusNode();

  const AmountTextField({super.key, this.initialValue, this.onSubmit});

  final double? initialValue;
  final Function(String)? onSubmit;

  @override
  ConsumerState<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends ConsumerState<AmountTextField> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) textController.text = '${widget.initialValue}';
  }

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
          textAlign: TextAlign.end,
          focusNode: AmountTextField.textFieldFocusNode,
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            suffix: Icon(Icons.euro_rounded),
            hintText: '0.00',
          ),
          style: theme.bodyLarge?.copyWith(
            fontSize: Insets.i56,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          onSubmitted: (String value) => widget.onSubmit?.call(value),
        ),
      ),
    );
  }
}

class DropDownRow extends ConsumerWidget {
  const DropDownRow({super.key, this.initialCategory, this.initialPaymentMethod, this.onCategorySelected, this.onPaymentSelected});

  final Category? initialCategory;
  final Function(int)? onCategorySelected;
  final PaymentMethod? initialPaymentMethod;
  final Function(int)? onPaymentSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesProvider);
    final asyncPaymentMethods = ref.watch(paymentMethodsProvider);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AsyncValueWidget(
            value: asyncCategories,
            data: (categories) {
              return Flexible(
                  child: RoundedDropdown(
                initialValue: initialCategory,
                items: categories ?? [],
                onSelected: (id) => onCategorySelected?.call(id),
                description: 'Category',
              ));
            }),
        gapH12,
        AsyncValueWidget(
            value: asyncPaymentMethods,
            data: (methods) {
              return Flexible(
                  child: RoundedDropdown(
                initialValue: initialPaymentMethod,
                items: methods ?? [],
                onSelected: (id) => onPaymentSelected?.call(id),
                description: 'Payment Methods',
              ));
            }),
      ],
    );
  }
}
