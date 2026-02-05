// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inventoryRepository)
final inventoryRepositoryProvider = InventoryRepositoryProvider._();

final class InventoryRepositoryProvider
    extends
        $FunctionalProvider<
          InventoryRepository,
          InventoryRepository,
          InventoryRepository
        >
    with $Provider<InventoryRepository> {
  InventoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<InventoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InventoryRepository create(Ref ref) {
    return inventoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InventoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InventoryRepository>(value),
    );
  }
}

String _$inventoryRepositoryHash() =>
    r'e1a71e03305d7e4345aa45910b00bf7b760b4c9d';

@ProviderFor(inventoryCategories)
final inventoryCategoriesProvider = InventoryCategoriesProvider._();

final class InventoryCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  InventoryCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryCategoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return inventoryCategories(ref);
  }
}

String _$inventoryCategoriesHash() =>
    r'c8bd00b539257daa505eee6e8be406f945b86706';

@ProviderFor(inventoryAssets)
final inventoryAssetsProvider = InventoryAssetsFamily._();

final class InventoryAssetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  InventoryAssetsProvider._({
    required InventoryAssetsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'inventoryAssetsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inventoryAssetsHash();

  @override
  String toString() {
    return r'inventoryAssetsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as int;
    return inventoryAssets(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InventoryAssetsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inventoryAssetsHash() => r'dc1b86c59a8f0cae209f2f03659da84cfa7392cc';

final class InventoryAssetsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Map<String, dynamic>>>, int> {
  InventoryAssetsFamily._()
    : super(
        retry: null,
        name: r'inventoryAssetsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  InventoryAssetsProvider call(int offset) =>
      InventoryAssetsProvider._(argument: offset, from: this);

  @override
  String toString() => r'inventoryAssetsProvider';
}

@ProviderFor(batchedAssets)
final batchedAssetsProvider = BatchedAssetsFamily._();

final class BatchedAssetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  BatchedAssetsProvider._({
    required BatchedAssetsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'batchedAssetsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$batchedAssetsHash();

  @override
  String toString() {
    return r'batchedAssetsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String?;
    return batchedAssets(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BatchedAssetsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$batchedAssetsHash() => r'8af79edea60f4132c1b9e98f9678780b7e93f36b';

final class BatchedAssetsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Map<String, dynamic>>>,
          String?
        > {
  BatchedAssetsFamily._()
    : super(
        retry: null,
        name: r'batchedAssetsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  BatchedAssetsProvider call(String? batch) =>
      BatchedAssetsProvider._(argument: batch, from: this);

  @override
  String toString() => r'batchedAssetsProvider';
}

@ProviderFor(userAssets)
final userAssetsProvider = UserAssetsProvider._();

final class UserAssetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  UserAssetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAssetsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAssetsHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return userAssets(ref);
  }
}

String _$userAssetsHash() => r'3bde6f64be527636a6e830ae639a294b6d15ef63';
