import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static const family = 'Inter';

  static TextTheme textTheme = const TextTheme(
    displaySmall: TextStyle(
      fontFamily: family,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
      height: 1.2,
    ),
    headlineSmall: TextStyle(
      fontFamily: family,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
      height: 1.25,
    ),
    titleMedium: TextStyle(
      fontFamily: family,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
      height: 1.3,
    ),
    bodyLarge: TextStyle(
      fontFamily: family,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: family,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
      height: 1.45,
    ),
    labelLarge: TextStyle(
      fontFamily: family,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.ink,
      height: 1.2,
    ),
    labelSmall: TextStyle(
      fontFamily: family,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.hover,
      height: 1.2,
    ),
  );
}
