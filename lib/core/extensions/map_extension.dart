import 'dart:convert';

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get prettyJson =>
      json.decode(const JsonEncoder.withIndent('    ').convert(this));

  Map<K, V> get clean {
    removeWhere((key, value) {
      if (value is Map || value is List) {
        return value is Map ? value.isEmpty : (value as List).isEmpty;
      } else {
        return key == null || value == null || value == 'null' || value == '';
      }
    });
    return this;
  }
}
