import 'package:fluffy_budget/core/constants.dart';
import 'package:fluffy_budget/features/expenses/data/local/category_dao.dart';
import 'package:fluffy_budget/features/expenses/domain/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

@Riverpod(keepAlive: true)
CategoryRepository categoryRepo(CategoryRepoRef ref){
  return CategoryRepository(ref, expenseCategories);
}

class CategoryRepository {
  final Set<Category> items;
  final Ref ref;

  const CategoryRepository(this.ref, this.items);

  Set<Category> get collection => items;

  Future<bool> isEmpty() async {
    return await ref.read(categoryDaoProvider).isEmpty();
  }

  initCategoryData() async {
    await ref.read(categoryDaoProvider).saveAll(expenseCategories.toList());
  }

  Future<List<Category>?> getAll() async {
    final categoryDao = ref.read(categoryDaoProvider);
    return await categoryDao.getAll();
  }
}