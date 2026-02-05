// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TabNotifier)
final tabProvider = TabNotifierProvider._();

final class TabNotifierProvider
    extends $NotifierProvider<TabNotifier, TabState> {
  TabNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tabNotifierHash();

  @$internal
  @override
  TabNotifier create() => TabNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TabState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TabState>(value),
    );
  }
}

String _$tabNotifierHash() => r'4b627f23c1f984a90bbf178420ad46b5d845a8e2';

abstract class _$TabNotifier extends $Notifier<TabState> {
  TabState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TabState, TabState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TabState, TabState>,
              TabState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
