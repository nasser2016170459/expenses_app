import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  final String tag;

  AppLogger(this.tag);

  void _printMessage(String? message, AnsiPen pen) {
    ansiColorDisabled = false;
    final msg = kReleaseMode ? message : pen("$message");
    debugPrint("[${DateTime.now()}] [$tag] $msg");
  }

  void info(String? message) {
    _printMessage(message, AnsiPen()..blue());
  }

  void error(String? message) {
    _printMessage(message, AnsiPen()..red());
  }

  void success(String? message) {
    _printMessage(message, AnsiPen()..green());
  }
}
