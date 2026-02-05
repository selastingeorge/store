
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/providers/http_provider.dart';
import 'package:store/repositories/dashboard_stats_repository.dart';
part 'dashboard_stats_provider.g.dart';

@Riverpod(keepAlive: true)
DashboardStatsRepository dashboardStatsRepository(Ref ref) {
  final httpService = ref.watch(httpServiceProvider);
  return DashboardStatsRepository(httpService);
}

@Riverpod(keepAlive: true)
Future<Map<String, dynamic>> dashboardCount(Ref ref) {
  return ref.read(dashboardStatsRepositoryProvider).getCount();
}