import 'package:flutter/material.dart';

enum AssetStatus {
  all('All Status'),
  fullyDepreciated('Fully Depreciated'),
  partiallyDepreciated('Partially Depreciated'),
  submitted('Submitted');

  const AssetStatus(this.label);

  final String label;

  static AssetStatus fromLabel(String label) =>
      AssetStatus.values.firstWhere((e) => e.label == label, orElse: () => AssetStatus.all);

  static Color? getStatusBackgroundColor(AssetStatus status) {
    switch (status) {
      case AssetStatus.fullyDepreciated:
        return Color(0xFFddeafd);
      case AssetStatus.partiallyDepreciated:
        return Color(0xFFfbf0c7);
      case AssetStatus.submitted:
        return Color(0xFFcff5e2);
      default:
        return Color(0xFF314158);
    }
  }

  static Color? getStatusForegroundColor(AssetStatus status) {
    switch (status) {
      case AssetStatus.fullyDepreciated:
        return Color(0xFF1447e6);
      case AssetStatus.partiallyDepreciated:
        return Color(0xFFbb4d00);
      case AssetStatus.submitted:
        return Color(0xFF007a55);
      default:
        return Colors.white;
    }
  }
}
