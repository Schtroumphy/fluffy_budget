import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/core/theme/app_theme.dart';
import 'package:fluffy_budget/features/expense/application/items_by_type_provider.dart';
import 'package:fluffy_budget/features/expense/domain/drop_down_item.dart';
import 'package:fluffy_budget/features/expense/presentation/expense_bottom_sheet.dart';
import 'package:fluffy_budget/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundedDropdown extends ConsumerStatefulWidget {
  const RoundedDropdown({
    super.key,
    required this.itemType, this.onSelected,
  });

  final ItemType itemType;
  final Function(int)? onSelected;

  @override
  ConsumerState<RoundedDropdown> createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends ConsumerState<RoundedDropdown> {
  DropDownItem? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemsAsyncValue = ref.watch(itemsByTypeProvider(widget.itemType));

    return AsyncValueWidget(value: itemsAsyncValue, data: (items) => DropdownButtonHideUnderline(
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
          hint: Text(widget.itemType.description),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          padding: const EdgeInsets.all(8),
          isExpanded: true,
          isDense: true,
          iconEnabledColor: AppColor.black.withOpacity(0.5),
          elevation: Insets.i8.toInt(),
          borderRadius: BorderRadius.circular(Insets.i24),
          dropdownColor: _dropdownValue?.color,
          value: _dropdownValue,
          onChanged: (DropDownItem? newValue) {
            setState(() {
              _dropdownValue = newValue;
              widget.onSelected?.call(newValue?.id ?? 0);
            });
            FocusScope.of(context).requestFocus(AmountTextField.textFieldFocusNode);
          },
          items: _buildItems(items),
        ),
      ),
    ));
  }

  List<DropdownMenuItem<DropDownItem>>? _buildItems(List<DropDownItem>? items) {
    return items?.map<DropdownMenuItem<DropDownItem>>((item) {
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
