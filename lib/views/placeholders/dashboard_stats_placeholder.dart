import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/views/widgets/stats_card.dart';

class DashboardStatsPlaceholder extends StatelessWidget {
  final int count;

  const DashboardStatsPlaceholder({super.key, this.count = 1});

  @override
  Widget build(BuildContext context) {
    int rows = (count / 2).ceil();

    List<Widget> rowWidgets = [];

    for (int rowIndex = 0; rowIndex < rows; rowIndex++) {
      List<Widget> cellWidgets = [];

      for (int colIndex = 0; colIndex < 2; colIndex++) {
        int itemIndex = rowIndex * 2 + colIndex;
        if (itemIndex < count) {
          cellWidgets.add(
            Expanded(
              child: Skeletonizer(
                child: StatsCard(
                  label: "Label $itemIndex",
                  icon: Icons.analytics,
                  value: 2000,
                  iconBackground:Color(0xFFeaeaf3),
                  iconForeground: Colors.black.withAlpha(30),
                  trendValue: 4,
                  showBackgroundIcon: false,
                ),
              ),
            ),
          );
        } else {
          // Empty space if count doesn't fill last row
          cellWidgets.add(const Expanded(child: SizedBox()));
        }
      }

      rowWidgets.add(Row(spacing: 15, children: [...cellWidgets]));
    }

    return Column(spacing: 15, children: rowWidgets);
  }
}
