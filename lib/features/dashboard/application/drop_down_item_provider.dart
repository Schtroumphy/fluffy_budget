import 'package:fluffy_budget/features/dashboard/data/drop_item_repository.dart';
import 'package:fluffy_budget/features/dashboard/domain/drop_down_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drop_down_item_provider.g.dart';

@Riverpod()
Future<List<DropDownItem>?> itemsByType(ItemsByTypeRef ref, ItemType type) async {
  return await ref.read(dropItemRepoProvider).getItemsByType(type);
}