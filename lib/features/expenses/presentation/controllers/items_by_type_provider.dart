import 'package:fluffy_budget/features/expenses/data/drop_item_repository.dart';
import 'package:fluffy_budget/features/expenses/domain/drop_down_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_by_type_provider.g.dart';

@Riverpod()
Future<List<DropDownItem>?> itemsByType(ItemsByTypeRef ref, ItemType type) async {
  return await ref.read(dropItemRepoProvider).getItemsByType(type);
}