import 'package:flutter/material.dart';
import 'package:store/core/theme/app_colors.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.light().copyWith(
    primary: AppColors.primary,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,
  ),

  /// Scaffold
  scaffoldBackgroundColor: AppColors.scaffoldBackground,

  /// AppBar
  appBarTheme: AppBarThemeData(
    backgroundColor: AppColors.appBarBackground,
    foregroundColor: AppColors.appBarIconColor,
  ),

  /// NavigationBar
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.navigationBackground,
    elevation: 0,
    indicatorColor: Colors.transparent,
    height: 75,
    overlayColor: WidgetStateProperty.all(AppColors.navigationIconRippleColor.withAlpha(30)),
    labelPadding: EdgeInsets.only(top: 2),
    shadowColor: AppColors.navigationShadowColor,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: AppColors.activeNavigationIconColor);
      }
      return const IconThemeData(color: AppColors.navigationIconColor);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          color: AppColors.activeNavigationLabelColor,
          fontVariations: [FontVariation('wght', 500)],
          fontSize: 12,
        );
      }
      return TextStyle(
        color: AppColors.navigationLabelColor,
        fontVariations: [FontVariation('wght', 500)],
        fontSize: 12,
      );
    }),
  ),

  /// Chip
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.chipBackground,
    selectedColor: AppColors.activeChipBackground,
    color: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.activeChipBackground;
      }
      return AppColors.chipBackground;
    }),

    showCheckmark: false,
    labelStyle: const TextStyle(
      fontSize: 12,
      color: AppColors.chipForeground,
      fontVariations: [FontVariation('wght', 600)],
    ),
    padding: EdgeInsets.symmetric(horizontal: 5),
    secondaryLabelStyle: const TextStyle(fontSize: 12, color: AppColors.activeChipForeground),
    shape: WidgetStateOutlinedBorder.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.transparent),
        );
      }
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.chipBorder),
      );
    }),
  ),

  tabBarTheme: TabBarThemeData(
    labelStyle: TextStyle(
      fontSize: 14,
      fontVariations: [FontVariation('wght', 500)],
      color: AppColors.tabBarLabel,
    ),
    labelColor: AppColors.activeTabBarLabel,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: AppColors.tabBarIndicator,
    dividerColor: Colors.transparent,
    labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  ),
);
