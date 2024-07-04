import 'package:fluffy_budget/core/database/dao.dart';
import 'package:fluffy_budget/core/database/database_notifier.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'category_dao.g.dart';

@Riverpod(keepAlive: true)
CategoryDao categoryDao(CategoryDaoRef ref) {
  return CategoryDao(ref);
}

class CategoryDao extends Dao<Category> {
  CategoryDao(this.ref) : super(tableName: "category");

  final Ref ref;

  @override
  Future<Database> get database => ref.read(databaseNotifierProvider.future);

  @override
  Map<String, dynamic> toEntity(Category model) {
    return model.toJson();
  }

  @override
  Category toModel(Map<String, dynamic> entity) {
    return Category.fromJson(entity);
  }
}