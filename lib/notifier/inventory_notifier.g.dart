// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InventoryNotifier)
final inventoryProvider = InventoryNotifierProvider._();

final class InventoryNotifierProvider
    extends $AsyncNotifierProvider<InventoryNotifier, InventoryState> {
  InventoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryNotifierHash();

  @$internal
  @override
  InventoryNotifier create() => InventoryNotifier();
}

String _$inventoryNotifierHash() => r'a573caac40c9dc039d8a3b4f5b0cdefd5f3116aa';

abstract class _$InventoryNotifier extends $AsyncNotifier<InventoryState> {
  FutureOr<InventoryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<InventoryState>, InventoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InventoryState>, InventoryState>,
              AsyncValue<InventoryState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
