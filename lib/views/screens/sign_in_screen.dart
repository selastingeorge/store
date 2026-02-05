import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/utils/dialog_utils.dart';
import 'package:store/core/utils/validation_utils.dart';
import 'package:store/notifier/auth_notifier.dart';
import 'package:store/providers/auth_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> handleSignIn() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      final user = await ref.read(authRepositoryProvider).signIn(email, password);
      if (user != null) {
        ref.read(authProvider.notifier).setUser(user);
        if (mounted) {
          context.go("/home");
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e, _) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        DialogUtils.showMessageDialog(context, "Sign In Error", e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = "jay_admin_executive@wes.com";
    _passwordController.text = "Hello@123";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Aboard',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 28,
                    fontVariations: [FontVariation('wght', 600)],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Please enter your credentials to continue",
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                    fontSize: 15,
                    fontVariations: [FontVariation('wght', 450)],
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidationUtils.validateEmail,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autofocus: false,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: ValidationUtils.validatePassword,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: !_isLoading
                              ? () async {
                                  if (!_signInFormKey.currentState!.validate()) return;
                                  await handleSignIn();
                                }
                              : null,
                          child: _isLoading
                              ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                              : Text("Sign In"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
