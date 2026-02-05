// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserNotifier)
final userProvider = UserNotifierProvider._();

final class UserNotifierProvider
    extends $NotifierProvider<UserNotifier, UserRole> {
  UserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotifierHash();

  @$internal
  @override
  UserNotifier create() => UserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRole value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRole>(value),
    );
  }
}

String _$userNotifierHash() => r'1c98afe3c0322dfbf5b9c65757eeff22e5d9e628';

abstract class _$UserNotifier extends $Notifier<UserRole> {
  UserRole build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserRole, UserRole>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserRole, UserRole>,
              UserRole,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
