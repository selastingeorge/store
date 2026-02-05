// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardStatsRepository)
final dashboardStatsRepositoryProvider = DashboardStatsRepositoryProvider._();

final class DashboardStatsRepositoryProvider
    extends
        $FunctionalProvider<
          DashboardStatsRepository,
          DashboardStatsRepository,
          DashboardStatsRepository
        >
    with $Provider<DashboardStatsRepository> {
  DashboardStatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardStatsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardStatsRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardStatsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardStatsRepository create(Ref ref) {
    return dashboardStatsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardStatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardStatsRepository>(value),
    );
  }
}

String _$dashboardStatsRepositoryHash() =>
    r'9d6913796438b91231ec61a4b83a98963446ae92';

@ProviderFor(dashboardCount)
final dashboardCountProvider = DashboardCountProvider._();

final class DashboardCountProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  DashboardCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardCountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardCountHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return dashboardCount(ref);
  }
}

String _$dashboardCountHash() => r'18d4f3ff43b168702b316badba8c6216024ed18e';
