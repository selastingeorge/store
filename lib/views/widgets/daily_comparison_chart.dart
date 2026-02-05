import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyComparisonChart extends StatelessWidget {
  const DailyComparisonChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 80,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.white,
              tooltipBorderRadius: BorderRadius.circular(8),
              tooltipBorder: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
              tooltipPadding: const EdgeInsets.all(12),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final dayName = days[group.x.toInt()];

                // Get both bar values for this day
                final bar1Value = group.barRods[0].toY.toInt();
                final bar2Value = group.barRods[1].toY.toInt();

                // Show tooltip with both values regardless of which bar is touched
                return BarTooltipItem(
                  '$dayName\n',
                  const TextStyle(
                    color: Color(0xFF2D3748),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'value 1 : $bar1Value\n',
                      style: const TextStyle(
                        color: Color(0xFFD4B5A0),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'value 2 : $bar2Value',
                      style: const TextStyle(
                        color: Color(0xFFE8A0A0),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              // Handle touch events if needed
            },
            handleBuiltInTouches: true,
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        days[value.toInt()],
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 35,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: const Color(0xFFE2E8F0), strokeWidth: 1);
            },
          ),
          barGroups: [
            _makeGroupData(0, 45, 12),
            _makeGroupData(1, 52, 19),
            _makeGroupData(2, 38, 8),
            _makeGroupData(3, 61, 25),
            _makeGroupData(4, 55, 22),
            _makeGroupData(5, 48, 15),
            _makeGroupData(6, 42, 10),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double value1, double value2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value1,
          color: const Color(0xFFe5d6ce),
          width: 20,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        ),
        BarChartRodData(
          toY: value2,
          color: const Color(0xFFf3c5c5),
          width: 20,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        ),
      ],
    );
  }
}
