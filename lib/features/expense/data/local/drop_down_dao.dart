import 'package:fluffy_budget/core/database/dao.dart';
import 'package:fluffy_budget/core/database/database_notifier.dart';
import 'package:fluffy_budget/features/expense/domain/drop_down_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'drop_down_dao.g.dart';

@Riverpod(keepAlive: true)
DropDownDao dropDownDao(DropDownDaoRef ref) {
  return DropDownDao(ref);
}

class DropDownDao extends Dao<DropDownItem> {
  DropDownDao(this.ref) : super(tableName: "drop_down_item");

  final Ref ref;

  @override
  Future<Database> get database => ref.read(databaseNotifierProvider.future);

  @override
  Map<String, dynamic> toEntity(DropDownItem model) {
    return model.toJson();
  }

  @override
  DropDownItem toModel(Map<String, dynamic> entity) {
    return DropDownItem.fromJson(entity);
  }
}