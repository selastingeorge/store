enum UserRole {
  l1,
  l2,
  manager,
  groupManager,
  admin;

  const UserRole();

  String get id {
    switch (this) {
      case UserRole.l1:
        return 'l1';
      case UserRole.l2:
        return 'l2';
      case UserRole.manager:
        return 'manager';
      case UserRole.groupManager:
        return 'group_manager';
      case UserRole.admin:
        return 'admin';
    }
  }

  String get name {
    switch (this) {
      case UserRole.l1:
        return 'L1';
      case UserRole.l2:
        return 'L2';
      case UserRole.manager:
        return 'Store Manager';
      case UserRole.groupManager:
        return 'Group Store Manager';
      case UserRole.admin:
        return 'Admin Executive';
    }
  }

  String get shortDisplayName {
    switch (this) {
      case UserRole.l1:
        return 'L1';
      case UserRole.l2:
        return 'L2';
      case UserRole.manager:
        return 'Manager';
      case UserRole.groupManager:
        return 'Group Manager';
      case UserRole.admin:
        return 'Admin';
    }
  }
}
