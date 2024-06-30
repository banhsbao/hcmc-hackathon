import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

enum TDSStatus {
  NORMAL,
  POLLUTED,
  UNKNOWN,
}

extension TDSStatusHelper on TDSStatus {
  static IconData getIcon(String? value) {
    final status = TDSStatus.values
        .firstWhere((e) => e.name.toLowerCase() == value?.toLowerCase());
    switch (status) {
      case TDSStatus.NORMAL:
        return FluentIcons.emoji_24_regular;
      case TDSStatus.POLLUTED:
        return FluentIcons.emoji_sad_24_regular;
      case TDSStatus.UNKNOWN:
        return FluentIcons.dismiss_circle_24_regular;
      default:
        return FluentIcons.dismiss_circle_24_regular;
    }
  }

  static String getName(String? value) {
    final status = TDSStatus.values
        .firstWhere((e) => e.name.toLowerCase() == value?.toLowerCase());
    switch (status) {
      case TDSStatus.NORMAL:
        return 'Normal';
      case TDSStatus.POLLUTED:
        return 'Polluted';
      case TDSStatus.UNKNOWN:
        return 'Unknown';
      default:
        return 'Unknown';
    }
  }

  // static Color getColor(String? value) {
  //   final status = TDSStatus.values
  //       .firstWhere((e) => e.name.toLowerCase() == value?.toLowerCase());
  //   switch (status) {
  //     case TDSStatus.NORMAL:
  //       return Colors.green;
  //     case TDSStatus.POLLUTED:
  //       return Colors.red;
  //     case TDSStatus.UNKNOWN:
  //       return Colors.grey;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  static Color getColorPH(double? value) {
    if (value == null) {
      return Colors.grey;
    }
    if (value < 6.5) {
      return Colors.red;
    } else if (value > 8.5) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
