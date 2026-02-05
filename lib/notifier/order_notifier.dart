import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/config.dart';
import 'package:store/providers/order_provider.dart';
import 'package:store/states/inventory_state.dart';
import 'package:store/states/order_state.dart';

part 'order_notifier.g.dart';

@Riverpod(keepAlive: true)
class OrderNotifier extends _$OrderNotifier {
  @override
  Future<OrderState> build() async {
    return OrderState(orders: [], offset: 0);
  }

  Future<List<Map<String, dynamic>>> fetchPage(int pageKey, {String? query, String? status}) async {
    final offset = (pageKey - 1) * Config.pageLimit;
    final repository = ref.watch(orderRepositoryProvider);
    return repository.getOrders(offset: offset, search: query, status: status);
  }
}
