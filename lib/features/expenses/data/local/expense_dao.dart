import 'package:fluffy_budget/core/database/dao.dart';
import 'package:fluffy_budget/core/database/database_notifier.dart';
import 'package:fluffy_budget/features/expenses/domain/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'expense_dao.g.dart';

@Riverpod(keepAlive: true)
ExpenseDao expenseDao(ExpenseDaoRef ref) {
  return ExpenseDao(ref);
}

class ExpenseDao extends Dao<Expense> {
  ExpenseDao(this.ref) : super(tableName: "expense");

  final Ref ref;

  @override
  Future<Database> get database => ref.read(databaseNotifierProvider.future);

  @override
  Map<String, dynamic> toEntity(Expense model) {
    return model.toJson();
  }

  @override
  Expense toModel(Map<String, dynamic> entity) {
    return Expense.fromJson(entity);
  }

  @override
  Future<void> save(Expense model) {
    final json = model.toJson();
    if(json['id'] == null) json.remove('id');
    return withDatabase((db) => db.insert(tableName, json, conflictAlgorithm: ConflictAlgorithm.replace));
  }
}