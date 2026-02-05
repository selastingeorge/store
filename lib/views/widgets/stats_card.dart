import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store/core/fonts/store_glyphs.dart';

class StatsCard extends StatelessWidget {
  final Color iconForeground;
  final Color iconBackground;
  final int value;
  final String label;
  final int trendValue;
  final IconData icon;
  final VoidCallback? onTap;
  final bool showBackgroundIcon;
  final String? trendValueSuffix;

  const StatsCard({
    super.key,
    this.iconForeground = const Color(0xFFFFFFFF),
    this.iconBackground = const Color(0xFF314158),
    this.value = 0,
    this.trendValue = 10,
    required this.label,
    required this.icon,
    this.onTap,
    this.showBackgroundIcon = true,
    this.trendValueSuffix
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern('en_IN');
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          highlightColor: Colors.grey.shade50,
          child: Stack(
            children: [
              if(showBackgroundIcon)
                Positioned(top: -14, right: -14, child: Icon(icon, size: 60, color: Color(0xFFF3F3F4))),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, size: 20, color: iconForeground),
                    ),
                    SizedBox(height: 8),
                    Text(
                      formatter.format(value),
                      style: TextStyle(fontSize: 22, fontVariations: [FontVariation('wght', 600)]),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                        fontVariations: [FontVariation('wght', 400)],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      spacing: 5,
                      children: [
                        if (trendValue < 0) ...[
                          Icon(StoreGlyphs.trendingDownMedium, size: 12, color: Colors.red),
                          Text(
                            "$trendValue${trendValueSuffix ?? ""}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontVariations: [FontVariation('wght', 500)],
                            ),
                          ),
                        ] else ...[
                          Icon(StoreGlyphs.trendingUpMedium, size: 12, color: Colors.green),
                          Text(
                            "+$trendValue${trendValueSuffix ?? ""}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontVariations: [FontVariation('wght', 500)],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
