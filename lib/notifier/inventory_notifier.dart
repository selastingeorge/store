import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/config.dart';
import 'package:store/providers/inventory_provider.dart';
import 'package:store/states/inventory_state.dart';

part 'inventory_notifier.g.dart';
@Riverpod(keepAlive: true)
class InventoryNotifier extends _$InventoryNotifier {

  @override
  Future<InventoryState> build() async {
    return InventoryState(assets: [], offset: 0);
  }

  Future<List<Map<String, dynamic>>> fetchPage(
      int pageKey, {
        String? query,
        String? category,
        String? status,
      }) async {
    final offset = (pageKey - 1) * Config.pageLimit;
    final repository = ref.watch(inventoryRepositoryProvider);
    return repository.getAssets(
      offset: offset,
      search: query,
      category: category,
      status: status,
    );
  }
}
