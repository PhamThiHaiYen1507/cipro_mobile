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

  static String getTimeDifferenceFromNow(DateTime date) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if (difference.inSeconds < 5) {
      return 'now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes <= 1) {
      return '1 minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours <= 1) {
      return '1 hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays <= 1) {
      return '1 day';
    } else if (difference.inDays < 6) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return '1 week ago';
    } else if ((difference.inDays / 7).ceil() < 4) {
      return '${(difference.inDays / 7).ceil()} weeks ago';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return '1 month ago';
    } else if ((difference.inDays / 30).ceil() < 30) {
      return '${(difference.inDays / 30).ceil()} months ago';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return '1 year ago';
    }
    return '${(difference.inDays / 365).floor()} years ago';
  }
}
