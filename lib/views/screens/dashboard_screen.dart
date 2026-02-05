import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/notifier/tab_notifier.dart';
import 'package:store/providers/dashboard_stats_provider.dart';
import 'package:store/views/placeholders/dashboard_stats_placeholder.dart';
import 'package:store/views/widgets/daily_comparison_chart.dart';
import 'package:store/views/widgets/elevated_card.dart';
import 'package:store/views/widgets/stats_card.dart';
import 'package:store/views/widgets/status_pi_chart.dart';
import 'package:store/views/widgets/weekly_activity_chart.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              spacing: 15,
              children: [
                ref
                    .watch(dashboardCountProvider)
                    .when(
                      data: (data) {
                        return Column(
                          spacing: 15,
                          children: [
                            Row(
                              spacing: 15,
                              children: [
                                Expanded(
                                  child: StatsCard(
                                    label: "Store Assets",
                                    icon: StoreGlyphs.inventoryMedium,
                                    value: data["total_asset_count"],
                                    trendValue: 5,
                                    trendValueSuffix: "%",
                                    iconBackground: Color(0xFFd2dce4),
                                    iconForeground: Color(0xFF314158),
                                    onTap: () {
                                      ref.read(tabProvider.notifier).setTab(1);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: StatsCard(
                                    label: "My Assets",
                                    icon: StoreGlyphs.dashboardMedium,
                                    value: data["item_count"],
                                    trendValue: -2,
                                    trendValueSuffix: "%",
                                    iconBackground: Color(0xFFdec3b3),
                                    iconForeground: Color(0xFF314158),
                                    onTap: () {
                                      context.push("/my-assets");
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 15,
                              children: [
                                Expanded(
                                  child: StatsCard(
                                    label: "Orders",
                                    icon: StoreGlyphs.ordersMedium,
                                    value: data["asset_order_count"],
                                    trendValue: -4,
                                    trendValueSuffix: "%",
                                    iconBackground: Color(0xFFdec3b3),
                                    iconForeground: Color(0xFF314158),
                                    onTap: () {
                                      ref.read(tabProvider.notifier).setTab(2);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: StatsCard(
                                    label: "Users",
                                    icon: StoreGlyphs.usersMedium,
                                    value: data["user_count"],
                                    trendValue: 4,
                                    trendValueSuffix: "%",
                                    iconBackground: Color(0xFFe8d5f2),
                                    iconForeground: Color(0xFF314158),
                                    onTap: () {
                                      context.push("/users");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      error: (e, t) {
                        return Text(e.toString());
                      },
                      loading: () {
                        return DashboardStatsPlaceholder(count: 4);
                      },
                    ),

                /// Charts
                SizedBox(
                  width: double.infinity,
                  child: ElevatedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Text(
                            "Weekly Activity",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF314158),
                              fontVariations: [FontVariation('wght', 500)],
                            ),
                          ),
                          WeeklyActivityChart(),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: ElevatedCard(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 15,
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF314158),
                                  fontVariations: [FontVariation('wght', 500)],
                                ),
                              ),
                              StatusPiChart(
                                data: [
                                  {'color': Color(0xFFd2dce4), 'value': 320, 'label': 'Furniture'},
                                  {'color': Color(0xFFdec3b3), 'value': 450, 'label': 'Electronics'},
                                  {'color': Color(0xFFf3c5c5), 'value': 190, 'label': 'Other'},
                                  {'color': Color(0xFFe5d6ce), 'value': 280, 'label': 'Vehicles'},
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedCard(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 15,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF314158),
                                  fontVariations: [FontVariation('wght', 500)],
                                ),
                              ),
                              StatusPiChart(
                                data: [
                                  {'color': Color(0xFFdec3b3), 'value': 680, 'label': 'In Use'},
                                  {'color': Color(0xFFe5d6ce), 'value': 140, 'label': 'Maintenance'},
                                  {'color': Color(0xFFd2dce4), 'value': 420, 'label': 'Available'},
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Text(
                            "Daily Comparison",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF314158),
                              fontVariations: [FontVariation('wght', 500)],
                            ),
                          ),
                          DailyComparisonChart(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
