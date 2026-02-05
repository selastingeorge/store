import 'dart:convert';
import 'dart:developer' as developer;
import 'package:store/config.dart';
import 'package:store/services/http_service.dart';

class OrderRepository {
  final HttpService _httpService;

  OrderRepository(this._httpService);

  Future<List<Map<String, dynamic>>> getOrders({int offset = 0, String? search, String? status}) async {
    await Future.delayed(const Duration(seconds: 2));
    final filters = <List<dynamic>>[];

    if (search != null && search.isNotEmpty) {
      filters.add(['name', 'like', '%$search%']);
    }
    if (status != null) {
      if (status != "All Status" && status.isNotEmpty) {
        filters.add(['status', '=', status]);
      }
    }

    final queryParams = <String, String>{
      'fields': jsonEncode(["*"]),
      'limit': Config.pageLimit.toString(),
      if (offset > 0) 'limit_start': offset.toString(),
      if (filters.isNotEmpty) 'filters': jsonEncode(filters),
    };

    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Asset Order',
      queryParams: queryParams,
      authenticated: true,
    );

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<List<Map<String, dynamic>>> getOrderItems(String orderId) async {

    final filters = <List<dynamic>>[];
    filters.add(["asset_order", "=", orderId]);

    final queryParams = <String, String>{
      'fields': jsonEncode(["*"]),
      'limit': Config.pageLimit.toString(),
      if (filters.isNotEmpty) 'filters': jsonEncode(filters),
    };

    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Asset Order Items',
      queryParams: queryParams,
      authenticated: true,
    );

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data ?? []);
  }
}
