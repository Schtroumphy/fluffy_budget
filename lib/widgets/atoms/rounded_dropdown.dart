import 'package:fluffy_budget/common/space.dart';
import 'package:fluffy_budget/core/theme/app_color.dart';
import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:fluffy_budget/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RoundedDropdown extends StatefulWidget {
  const RoundedDropdown({super.key});

  @override
  State<RoundedDropdown> createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends State<RoundedDropdown> {
  var _dropdownValue = DropdownItem.values.first;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.i24),
            borderSide: BorderSide(width: 1, color: _dropdownValue.color!),
          ),
          filled: true,
          fillColor: _dropdownValue.color?.withOpacity(0.8),
        ),
        child: DropdownButton(
          //style: theme.textTheme.labelMedium,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          padding: const EdgeInsets.all(8),
          isExpanded: true,
          isDense: true,
          iconEnabledColor: AppColor.black,
          elevation: Insets.i8.toInt(),
          borderRadius: BorderRadius.circular(Insets.i24),
          dropdownColor: _dropdownValue.color,
          value: _dropdownValue.label,
          onChanged: (String? newValue) {
            setState(() {
              _dropdownValue = DropdownItem.getByLabel(newValue);
            });
          },
          items: _buildItems(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>>? _buildItems() {
    const items = DropdownItem.values;

    final List<DropdownMenuItem<String>> test = items.map<DropdownMenuItem<String>>((e) {
      return DropdownMenuItem<String>(
        value: e.label,
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(e.icon),
            gapH6,
            Text(e.label, style: TextStyles.interM,)
          ],
        ),
      );
    }).toList();

    return test;
  }
}

enum DropdownItem {
  cash      (label: "Cash", icon: Icons.attach_money_rounded, color: AppColor.yellow),
  creditCard(label: "Credit card", icon: Icons.credit_card_rounded, color: AppColor.purple),
  lydia     (label: "Lydia", icon: Icons.phone_iphone, color: AppColor.blue),
  paypal    (label: "Paypal", icon: Icons.paypal_rounded, color: AppColor.green),
  other     (label: "Other", icon: Icons.shopping_basket_rounded, color: AppColor.purple);

  final String label;
  final IconData icon;
  final Color? color;

  const DropdownItem({required this.label, required this.icon, this.color});

  static DropdownItem getByLabel(String? label) => values.firstWhere((item) => item.label == label, orElse: () => other);
}
