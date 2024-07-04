import 'package:fluffy_budget/features/expenses/domain/expense_property.dart';
import 'package:fluffy_budget/widgets/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/core/theme/app_theme.dart';
import 'package:fluffy_budget/features/expenses/presentation/add_expense/add_expense_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundedDropdown extends ConsumerStatefulWidget {
  const RoundedDropdown({
    super.key,
    required this.description,
    required this.items,
    this.onSelected,
  });

  final String description;
  final List<ExpenseProperty> items;
  final Function(int)? onSelected;

  @override
  ConsumerState<RoundedDropdown> createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends ConsumerState<RoundedDropdown> {
  ExpenseProperty? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.i24),
            borderSide: BorderSide(width: 1, color: _dropdownValue?.color ?? Colors.grey.withOpacity(0.4)),
          ),
          filled: true,
          fillColor: _dropdownValue?.color?.withOpacity(0.8),
        ),
        child: DropdownButton(
          style: theme.textTheme.labelMedium,
          autofocus: false,
          hint: Text(widget.description),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          padding: const EdgeInsets.all(8),
          isExpanded: true,
          isDense: true,
          iconEnabledColor: AppColor.black.withOpacity(0.5),
          elevation: Insets.i8.toInt(),
          borderRadius: BorderRadius.circular(Insets.i24),
          dropdownColor: _dropdownValue?.color,
          value: _dropdownValue,
          onChanged: (ExpenseProperty? newValue) {
            setState(() {
              _dropdownValue = newValue;
              widget.onSelected?.call(newValue?.id ?? 0);
            });
            FocusScope.of(context).requestFocus(AmountTextField.textFieldFocusNode);
          },
          items: _buildItems(widget.items),
        ),
      ),
    );
  }

  List<DropdownMenuItem<ExpenseProperty>>? _buildItems(List<ExpenseProperty>? items) {
    return items?.map<DropdownMenuItem<ExpenseProperty>>((item) {
      return DropdownMenuItem<ExpenseProperty>(
        value: item,
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(item.icon),
            gapH6,
            Text(item.label, style: TextStyles.interM),
          ],
        ),
      );
    }).toList();
  }
}
