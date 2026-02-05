import 'dart:convert';
import 'package:store/config.dart';
import 'package:store/services/http_service.dart';

class DashboardStatsRepository {
  final HttpService _httpService;

  DashboardStatsRepository(this._httpService);

  Future<Map<String, dynamic>> getCount() async {
    final response = await _httpService.post(
      url: "${Config.apiUrl}/api/method/store_management.v2.get_dashboard.get_dashboard_data",
      authenticated: true
    );

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final count = responseJson["message"]["data"];
    return count;
  }
}
