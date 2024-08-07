import 'package:fluffy_budget/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BudgetScreen extends StatefulWidget {
  static String location = "/screen2";

  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  String? barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: Insets.i56),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text("Budget Screen"),
              Text("Barcode : $barcode"),
              ElevatedButton(onPressed: () => _onAddBarcodePressed(context), child: const Text("Add barcode")),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  _onAddBarcodePressed(BuildContext context) async {
    var res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SimpleBarcodeScannerPage()));

    setState(() {
      if (res is String) {
        barcode = res;
      }
    });
  }
}
