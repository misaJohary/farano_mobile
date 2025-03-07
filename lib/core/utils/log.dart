import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Logger for the terminal more visible and colorfull
/// very handy for debugging

class Log {
  static void error(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.e(message);
    }
  }

  static void warning(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.w(message);
    }
  }

  static void debug(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.d(message);
    }
  }

  static void info(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.i(message);
    }
  }
}