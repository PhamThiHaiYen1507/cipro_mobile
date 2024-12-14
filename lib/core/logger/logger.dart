import 'dart:convert';

import 'package:base_project/core/extensions/map_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

part 'custom_printer.dart';

final _logger = Logger(
  printer: CustomPrinter(
    printTime: true,
    methodCount: 8,
  ),
);

void logD(dynamic message) {
  _log(Level.debug, message);
}

void logW(dynamic message) {
  _log(Level.warning, message);
}

void logE(dynamic message, [StackTrace? stackTrace, dynamic error]) {
  _log(Level.error, message, error, stackTrace);
}

void _log(Level level, dynamic message,
    [dynamic error, StackTrace? stackTrace]) {
  if (kDebugMode) {
    if (message is List || message is Iterable) {
      _logger.log(
          level,
          message.map((e) {
            if (e is Map) return e.prettyJson;
            dynamic mess = e;
            try {
              if (![String, int, num, double, List, Map, Set]
                  .contains(mess.runtimeType)) {
                mess = e.toJson();
              }
            } catch (_) {}

            return mess is Map ? mess.prettyJson : mess;
          }).toList(),
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace);
    } else if (message is Map) {
      final json = {};
      message.forEach((key, value) {
        dynamic v = value;
        try {
          if (![String, int, num, double, List, Map, Set]
              .contains(v.runtimeType)) {
            v = value.toJson();
          }
        } catch (_) {}
        json[key] = v;
      });
      _logger.log(level, json.prettyJson,
          time: DateTime.now(), error: error, stackTrace: stackTrace);
    } else if (message is Iterable<Map>) {
      _logger.log(level, message.map((e) => e.prettyJson).toList(),
          time: DateTime.now(), error: error, stackTrace: stackTrace);
    } else {
      dynamic v = message;
      try {
        if (![String, int, num, double, List, Map, Set]
            .contains(v.runtimeType)) {
          v = message.toJson();
        }
      } catch (_) {}

      _logger.log(level, v,
          time: DateTime.now(), error: error, stackTrace: stackTrace);
    }
  }
}
