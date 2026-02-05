import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyActivityChart extends StatefulWidget {
  const WeeklyActivityChart({super.key});

  @override
  State<WeeklyActivityChart> createState() => _WeeklyActivityChartState();
}

class _WeeklyActivityChartState extends State<WeeklyActivityChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: const Color(0xFFE2E8F0).withAlpha(100), strokeWidth: 1, dashArray: [5, 5]);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(color: const Color(0xFFE2E8F0), strokeWidth: 1, dashArray: [5, 5]);
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  final index = value.toInt();
                  if (index >= 0 && index < days.length && value == index.toDouble()) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        days[index],
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                    );
                  }
                  return const Text('');
                },
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
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
            ),
          ),
          minX: 0,
          maxX: 6.2,
          minY: 0,
          maxY: 80,
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => Colors.white,
              tooltipBorderRadius: BorderRadius.circular(8),
              tooltipBorder: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
              tooltipPadding: const EdgeInsets.all(12),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                if (touchedSpots.isEmpty) return [];

                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final dayIndex = touchedSpots.first.x.toInt();
                final dayName = days[dayIndex];

                // Get values for both series at this x position
                double assetsValue = 0;
                double ordersValue = 0;

                for (var spot in touchedSpots) {
                  if (spot.barIndex == 0) {
                    assetsValue = spot.y;
                  } else if (spot.barIndex == 1) {
                    ordersValue = spot.y;
                  }
                }

                // Return one item per touched spot
                return touchedSpots.map((spot) {
                  if (spot.barIndex == 0) {
                    // First item shows everything
                    return LineTooltipItem(
                      textAlign: TextAlign.start,
                      '$dayName\n',
                      const TextStyle(
                        color: Color(0xFF2D3748),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'assets : ${assetsValue.toInt()}\n',
                          style: const TextStyle(
                            color: Color(0xFF8BADC7),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: 'orders : ${ordersValue.toInt()}',
                          style: const TextStyle(
                            color: Color(0xFFD4B5A0),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Second item is empty (we show everything in first item)
                    return const LineTooltipItem('', TextStyle(fontSize: 0));
                  }
                }).toList();
              },
            ),
            getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(color: const Color(0xFFCBD5E1), strokeWidth: 1.5),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      Color dotColor = barData.color ?? const Color(0xFF8BADC7);
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: dotColor,
                      );
                    },
                  ),
                );
              }).toList();
            },
            handleBuiltInTouches: true,
            touchSpotThreshold: 50,
          ),
          lineBarsData: [
            // Blue area (assets)
            LineChartBarData(
              spots: const [
                FlSpot(0, 45),
                FlSpot(1, 52),
                FlSpot(2, 38),
                FlSpot(3, 61),
                FlSpot(4, 55),
                FlSpot(5, 48),
                FlSpot(6, 42),
              ],
              isCurved: true,
              curveSmoothness: 0.4,
              color: const Color(0xFFD2DCE4),
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFD2DCE4).withAlpha(153),
                    const Color(0xFFD2DCE4).withAlpha(77),
                    const Color(0xFFD2DCE4).withAlpha(13),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Beige/tan area (orders)
            LineChartBarData(
              spots: const [
                FlSpot(0, 12),
                FlSpot(1, 19),
                FlSpot(2, 8),
                FlSpot(3, 25),
                FlSpot(4, 22),
                FlSpot(5, 15),
                FlSpot(6, 10),
              ],
              isCurved: true,
              curveSmoothness: 0.4,
              color: const Color(0xFFDEC3B3),
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFDEC3B3).withAlpha(153),
                    const Color(0xFFDEC3B3).withAlpha(77),
                    const Color(0xFFDEC3B3).withAlpha(13),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
