import 'dart:ui';

import '../helpers/app_colors.dart';

enum NotificationType {
  error(AppColors.errorColor),
  waiting(AppColors.warning),
  success(AppColors.green);

  const NotificationType(this.color);

  final Color color;
}
