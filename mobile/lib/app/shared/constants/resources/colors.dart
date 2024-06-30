import 'package:flutter/material.dart';

/// Define app colors
@immutable
class AppColorStyles {
  //* Primary colors
  final transparent = Colors.transparent;
  final black = const Color(0xff000000);
  final white = const Color(0xffFFFFFF);
  final warning = Colors.amber.shade600;
  final success = const Color(0xff28854a);

  //* Shimmer loading colors
  final shimmerBaseColor = Colors.grey.shade300;
  final shimmerHighlightColor = Colors.grey.shade100;
  final shimmerContentColor = Colors.white.withOpacity(0.85);

  //* Shadow colors
  final shadow = const Color(0x0f000000);
  final shadowBottomBar = const Color(0x1a2c272e);
  final shadowCard = const Color(0x29000000);

  //* Grey colors
  final grey = const Color(0xff4f4f4f);
  final grey1 = const Color(0xff949494);
  final grey2 = const Color(0xffB5B5B5);
  final grey3 = const Color(0xffD7D7D7);
  final grey4 = const Color(0xffF8F8F8);
}
