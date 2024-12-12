import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

abstract class NumberPattern {
  static const interger = '#,##0';
  static const decimal = '#,##0.##';
  static const percent = '#,##0.##%';
  static const percentInterger = '#,##0%';
}

abstract class Utils {
  static String get generateId => const Uuid().v4();

  static String formatNumber(
    num? value, {
    String pattern = NumberPattern.decimal,
    num? multiplier,
    String? defaultValue,
    String? suffix,
  }) {
    final NumberFormat numberFormat =
        NumberFormat('$pattern${suffix?.isNotEmpty == true ? ' $suffix' : ''}');
    if (value != null) {
      num data = value;
      if (multiplier != null && multiplier != 0) {
        data = value / multiplier;
      }

      return data == 0
          ? (defaultValue ?? numberFormat.format(data))
          : numberFormat.format(data);
    } else {
      return defaultValue ?? numberFormat.format(0);
    }
  }

  static String formatDateToDisplay(DateTime? time, [String? outputFormat]) {
    if (time == null) return '';
    final output = DateFormat(outputFormat ?? 'dd/MM/yyyy');
    return output.format(time);
  }
}
