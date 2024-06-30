import 'package:flutter/material.dart';

import '../constants/resources/colors.dart';
import '../constants/resources/durations.dart';
import '../constants/resources/styles.dart';
import '../constants/secure/keys.dart';
import '../constants/secure/stores.dart';
import '../styles/app_theme.dart';

/// Configuration
@immutable
class AppConfig {
  //* Language
  static const defaultLanguageCode = 'en';
  static const defaultIsoCountryCode = 'EN';
  static const alternativeLanguageCode = 'vi';
  static const alternativeIsoCountryCode = 'VN';

  final defaultLocale = const Locale(
    defaultLanguageCode,
    defaultIsoCountryCode,
  );
  final alternativeLocale = const Locale(
    alternativeLanguageCode,
    alternativeIsoCountryCode,
  );

  //* Immutable
  late final box = AppStoreKeys();
  late final keys = AppFormKeys();
  late final styles = AppTextStyles();
  late final theme = AppColorStyles();
  late final times = AppTimes();
  late final defaultTheme = AppTheme.mainTheme();
}
