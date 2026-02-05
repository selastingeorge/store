
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/providers/http_provider.dart';
import 'package:store/repositories/order_repository.dart';
part 'order_provider.g.dart';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) {
  final httpService = ref.read(httpServiceProvider);
  return OrderRepository(httpService);
}

@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> orders(Ref ref,int offset) {
  return ref.read(orderRepositoryProvider).getOrders(offset: offset);
}

@Riverpod(keepAlive: true)
Future<List<Map<String, dynamic>>> items(Ref ref,String orderId) {
  return ref.read(orderRepositoryProvider).getOrderItems(orderId);
}