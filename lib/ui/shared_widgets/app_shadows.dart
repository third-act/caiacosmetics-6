import 'package:flutter/material.dart';

abstract final class AppShadows {
  static List<BoxShadow> get soft => const [
        BoxShadow(
          color: Color(0x14333333),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get card => const [
        BoxShadow(
          color: Color(0x12333333),
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get tabPill => const [
        BoxShadow(
          color: Color(0x20333333),
          blurRadius: 28,
          offset: Offset(0, 10),
        ),
      ];
}
