import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/models/user.dart';
import 'package:store/notifier/auth_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    authenticateUser();
  }

  Future<void> authenticateUser() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("user");

    if (!mounted) return;
    if (userData == null) {
      context.go("/sign-in");
      return;
    }

    try {
      final Map<String, dynamic> userMap = jsonDecode(userData);
      final User user = User.fromJson(userMap);
      ref.read(authProvider.notifier).setUser(user);
      context.go("/home");
    } catch (e) {
      await prefs.remove("user");
      if (!mounted) return;
      context.go("/sign-in");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset("assets/images/logo.svg", width: 90, height: 90)),
          SizedBox(height: 50),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100),
            child: LinearProgressIndicator(
              backgroundColor: colorScheme.onSurfaceVariant.withAlpha(30),
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFF3d6935),
            ),
          ),
        ],
      ),
    );
  }
}
