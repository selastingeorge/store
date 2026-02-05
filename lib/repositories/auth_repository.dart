import 'package:store/models/user.dart';
import 'package:store/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<User?> signIn(String username, String password) async {
    return _authService.signIn(username, password);
  }

  Future<void> signOut() async {
    return _authService.signOut();
  }
}
