import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/core/types/user_role.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  UserRole build() {
    return UserRole.admin;
  }

  void setUserRole(UserRole role) {
    state = role;
  }

  void setUserRoleFromString(String value) {
    state = UserRole.values.firstWhere((role) => role.id == value, orElse: () => UserRole.admin);
  }
}
