import 'package:flutter/material.dart';

/// Define durations
@immutable
class AppTimes {
  final fast = const Duration(milliseconds: 300);
  final med = const Duration(milliseconds: 600);
  final regular = const Duration(milliseconds: 500);
  final slow = const Duration(milliseconds: 900);
  final verySlow = const Duration(milliseconds: 1200);

  final pageTransition = const Duration(milliseconds: 200);
  final timeOut = const Duration(seconds: 30);

  final oneSeconds = const Duration(seconds: 1);
  final twoSeconds = const Duration(seconds: 2);
  final threeSeconds = const Duration(seconds: 3);
  final fiveSeconds = const Duration(seconds: 5);

  final fetchPeriod = const Duration(milliseconds: 1500);
}
