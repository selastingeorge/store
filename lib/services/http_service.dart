import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:store/providers/auth_provider.dart';

class HttpService {
  final Ref _ref;
  HttpService(this._ref);

  Future<String?> _getAuthToken() async {
    final token = await _ref.read(authServiceProvider).token;
    return token;
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool authenticated = false,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final token = authenticated ? await _getAuthToken() : null;
    final defaultHeaders = <String, String>{
      'Accept': 'application/json',
      if (token != null) 'Cookie': 'sid=$token',
    };
    return http.get(uri, headers: {...defaultHeaders, ...?headers});
  }

  Future<http.Response> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool authenticated = false,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final token = authenticated ? await _getAuthToken() : null;
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Cookie': 'sid=$token',
    };

    return await http.post(
      uri,
      headers: {...defaultHeaders, ...?headers},
      body: body != null ? jsonEncode(body) : null,
    );
  }
}
