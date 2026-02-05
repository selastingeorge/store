
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/providers/http_provider.dart';
import 'package:store/repositories/inventory_repository.dart';
part 'inventory_provider.g.dart';

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) {
  final httpService = ref.read(httpServiceProvider);
  return InventoryRepository(httpService);
}

@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> inventoryCategories(Ref ref) {
  return ref.read(inventoryRepositoryProvider).getCategories();
}

@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> inventoryAssets(Ref ref,int offset) {
  return ref.read(inventoryRepositoryProvider).getAssets(offset: offset);
}


@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> batchedAssets(Ref ref,String? batch) {
  return ref.read(inventoryRepositoryProvider).getBatchedAssets(batch: batch);
}

@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> userAssets(Ref ref) {
  return ref.read(inventoryRepositoryProvider).getUserAssets();
}