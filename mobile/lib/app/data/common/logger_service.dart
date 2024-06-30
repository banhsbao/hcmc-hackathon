import 'package:flutter/foundation.dart';

import 'package:talker_flutter/talker_flutter.dart';

import '../../shared/constants/enums/systems.dart';

/// Logger
class LoggerService {
  static LogMode _logMode = LogMode.debug;
  LogMode get mode => _logMode;
  Talker get talker => _talker;

  final _talker = TalkerFlutter.init(
    settings: TalkerSettings(
      maxHistoryItems: 100,
      enabled: _logMode == LogMode.debug,
      titles: {
        TalkerLogType.critical: '👾',
        TalkerLogType.debug: '🐛',
        TalkerLogType.error: '⛔',
        TalkerLogType.exception: '⛔',
        TalkerLogType.httpError: '⛔',
        TalkerLogType.httpRequest: '☁️',
        TalkerLogType.httpResponse: '💬',
        TalkerLogType.info: '💡',
        TalkerLogType.verbose: '🔉',
        TalkerLogType.warning: '⚠️',
      },
    ),
    logger: TalkerLogger(),
  );

  Future<void> initLogger() async {
    LoggerService._logMode = kReleaseMode ? LogMode.release : LogMode.debug;
  }

  void dispose() {
    _talker.cleanHistory();
  }

  //* Log handler
  void handle(Object error, StackTrace stackTrace) {
    _talker.handle(error, stackTrace);
  }

  //* Log a message at level [Level.verbose].
  void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.verbose(message, error, stackTrace);
  }

  //* Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.debug(message, error, stackTrace);
  }

  //* Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.info(message, error, stackTrace);
  }

  //* Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.warning(message, error, stackTrace);
  }

  //* Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.error(message, error, stackTrace);
  }

  //* Log a message at level [Level.fatal].
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.critical(message, error, stackTrace);
  }
}
