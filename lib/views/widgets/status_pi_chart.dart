import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatusPiChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final double height;

  const StatusPiChart({
    super.key,
    required this.data,
    this.height = 100,
  });

  @override
  State<StatusPiChart> createState() => _StatusPiChartState();
}

class _StatusPiChartState extends State<StatusPiChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: widget.height,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 25,
              pieTouchData: PieTouchData(
                touchCallback: (event, pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse?.touchedSection != null &&
                        event.isInterestedForInteractions) {
                      touchedIndex =
                          pieTouchResponse!.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = null;
                    }
                  });
                },
              ),
              sections: List.generate(widget.data.length, (i) {
                final isTouched = i == touchedIndex;
                return PieChartSectionData(
                  color: widget.data[i]['color'] as Color,
                  value: double.tryParse(
                      widget.data[i]['value'].toString()) ??
                      0,
                  title: '',
                  radius: isTouched ? 25 : 20,
                );
              }),
            ),
          ),
        ),
        if (touchedIndex != null &&
            touchedIndex! >= 0 &&
            touchedIndex! < widget.data.length)
          Positioned(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                '${widget.data[touchedIndex!]['label']}: ${widget.data[touchedIndex!]['value']}',
                style: TextStyle(color: colorScheme.onSurface, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
