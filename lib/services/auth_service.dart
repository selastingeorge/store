import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/config.dart';
import 'package:store/models/user.dart';
import 'package:store/services/http_service.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  Future<User?> signIn(String username, String password) async {
    final response = await _httpService.post(
      url: "${Config.apiUrl}/api/method/store_management.v2.login.app_login",
      body: {"usr": username, "pwd": password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] == false) {
        throw Exception(data["message"]);
      }

      final userData = data["user_details"];
      final prefs = await SharedPreferences.getInstance();
      final user = User(
        email: userData["email"],
        fullName: userData["full_name"],
        roleProfileName: userData["role_profile_name"],
        roles: userData["roles"],
        employeeId: userData["employee_id"],
        authToken: data["sid"],
      );

      prefs.setString("user", jsonEncode(user.toJson()));
      return user;
    } else {
      throw Exception("Unable to sign in. Please try again later");
    }
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  Future<String?> get token async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString("user");
      if (userJson == null) return null;
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return userMap["authToken"] as String?;
    } catch (e) {
      developer.log("Failed to read auth token: $e");
      return null;
    }
  }
}
