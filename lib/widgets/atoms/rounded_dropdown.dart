import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/core/theme/app_theme.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:fluffy_budget/features/dashboard/presentation/expense/expense_bottom_sheet.dart';
import 'package:flutter/material.dart';

class RoundedDropdown extends StatefulWidget {
  const RoundedDropdown({
    super.key,
    required this.items,
  });

  final Set<DropDownItem> items;

  @override
  State<RoundedDropdown> createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends State<RoundedDropdown> {
  late DropDownItem? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.i24),
            borderSide: BorderSide(width: 1, color: _dropdownValue!.color!),
          ),
          filled: true,
          fillColor: _dropdownValue?.color?.withOpacity(0.8),
        ),
        child: DropdownButton(
          style: theme.textTheme.labelMedium,
          autofocus: false,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          padding: const EdgeInsets.all(8),
          isExpanded: true,
          isDense: true,
          iconEnabledColor: AppColor.black,
          elevation: Insets.i8.toInt(),
          borderRadius: BorderRadius.circular(Insets.i24),
          dropdownColor: _dropdownValue!.color,
          value: _dropdownValue,
          onChanged: (DropDownItem? newValue) {
            setState(() {
              _dropdownValue = newValue;
            });
            FocusScope.of(context).requestFocus(AmountTextField.textFieldFocusNode);
          },
          items: _buildItems(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<DropDownItem>>? _buildItems() {
    return widget.items.map<DropdownMenuItem<DropDownItem>>((item) {
      return DropdownMenuItem<DropDownItem>(
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
