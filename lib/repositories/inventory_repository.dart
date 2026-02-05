import 'dart:convert';
import 'dart:developer' as developer;
import 'package:store/config.dart';
import 'package:store/services/http_service.dart';

class InventoryRepository {
  final HttpService _httpService;

  InventoryRepository(this._httpService);

  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Item Group',
      authenticated: true,
    );

    if (response.statusCode != 200) {
      developer.log('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load categories: ${response.statusCode}');
    }

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final data = responseJson["data"];

    if (data == null) {
      developer.log('No data found in response');
      return [
        {"name": "all"},
      ];
    }

    final categories = List<Map<String, dynamic>>.from(data);
    return [
      {"name": "all"},
      ...categories,
    ];
  }


  Future<List<Map<String, dynamic>>> getAssets({
    int offset = 0,
    String? search,
    String? category,
    String? status,
  }) async {
    /// I have Added a small delay to show pagination,
    /// since API was fast, pagination was not visible
    await Future.delayed(const Duration(seconds: 2));
    final filters = <List<dynamic>>[];

    if (search != null && search.isNotEmpty) {
      filters.add(['asset_name', 'like', '%$search%']);
    }

    if (category != null && category.isNotEmpty) {
      filters.add(['asset_category', '=', category]);
    }

    if (status != null && status.isNotEmpty) {
      filters.add(['status', '=', status]);
    }

    final queryParams = <String, String>{
      'fields': jsonEncode(["*"]),
      'limit': Config.pageLimit.toString(),
      if (offset > 0) 'limit_start': offset.toString(),
      if (filters.isNotEmpty) 'filters': jsonEncode(filters),
    };

    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Asset',
      queryParams: queryParams,
      authenticated: true,
    );

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<List<Map<String, dynamic>>> getUserAssets() async {
    final filters = <List<dynamic>>[];

    final queryParams = <String, String>{
      'fields': jsonEncode(["*"]),
      'limit':"5",
      if (filters.isNotEmpty) 'filters': jsonEncode(filters),
    };

    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Asset',
      queryParams: queryParams,
      authenticated: true,
    );

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<List<Map<String, dynamic>>> getBatchedAssets({
    String? batch
  }) async {
    final filters = <List<dynamic>>[];
    filters.add(['custom_batch', '=', batch]);

    final queryParams = <String, String>{
      'fields': jsonEncode(["*"]),
      'limit': Config.pageLimit.toString(),
      if (filters.isNotEmpty) 'filters': jsonEncode(filters),
    };

    final response = await _httpService.get(
      url: '${Config.apiUrl}/api/resource/Asset',
      queryParams: queryParams,
      authenticated: true,
    );

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data ?? []);
  }


}
