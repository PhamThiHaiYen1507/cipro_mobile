import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  BoxDecoration get defaultBox => BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadius.sm,
        boxShadow: [
          BoxShadow(
            color: Colors.black.o(0.1),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      );
}
