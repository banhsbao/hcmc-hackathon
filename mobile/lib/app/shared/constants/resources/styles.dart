import 'package:flutter/material.dart';

import '../../../data/di.dart';

/// Define text styles
@immutable
class AppTextStyles {
  final TextStyle pRegular = TextStyle(
    fontWeight: FontWeight.w400,
    color: $r.theme.black,
    letterSpacing: 0,
  );

  final TextStyle pMedium = TextStyle(
    fontWeight: FontWeight.w500,
    color: $r.theme.black,
    letterSpacing: 0,
  );

  final TextStyle pSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    color: $r.theme.black,
    letterSpacing: 0,
  );

  final TextStyle pBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: $r.theme.black,
    letterSpacing: 0,
  );
}
