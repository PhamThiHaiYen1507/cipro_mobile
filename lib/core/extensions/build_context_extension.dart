import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  BoxDecoration get defaultBox => BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadius.sm,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      );
}
