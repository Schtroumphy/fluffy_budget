import 'package:intl/intl.dart';

extension DateTimeNullable on DateTime? {
  String get dM => DateFormat.d().add_MMM().format(this ?? DateTime.now());
  String get yMd => DateFormat.yMd().format(this ?? DateTime.now());
  String get Hms => DateFormat.Hms().format(this ?? DateTime.now());
  String get yMMMd => DateFormat.yMMMd().format(this ?? DateTime.now());
}