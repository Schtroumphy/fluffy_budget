import 'package:flutter/material.dart';

class CloseSheetBar extends StatelessWidget {
  const CloseSheetBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 4,
      width: screenWidth/8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey,
      ),
      child: const SizedBox.shrink(),
    );
  }
}