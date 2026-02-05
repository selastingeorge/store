import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/models/user.dart';
import 'package:store/states/auth_state.dart';
part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState(null);
  }

  void setUser(User user) {
    state = AuthState(user);
  }
}
