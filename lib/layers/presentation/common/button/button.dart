import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool disabled;

  final void Function() onPressed;

  final Widget? child;

  final Color? backgroundColor;

  final Color? borderColor;

  final Color? disabledBackgroundColor;

  final Color? disabledForegroundColor;

  final Color? foregroundColor;

  final BorderRadius? borderRadius;

  final EdgeInsetsGeometry? padding;

  final num height;

  final double? width;

  final TextStyle? textStyle;

  final Widget? loadingItem;

  final BorderSide? side;

  const Button({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.loadingItem,
    this.width,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.height = 44,
    this.side,
    this.foregroundColor,
  });

  factory Button.border({
    required final void Function() onPressed,
    required Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? side,
    double height = 36,
    EdgeInsetsGeometry? padding,
  }) {
    return Button(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? Colors.transparent,
      side: side ?? const BorderSide(color: AppColors.primaryColor),
      foregroundColor: foregroundColor ?? AppColors.primaryColor,
      height: height,
      padding: padding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      width: width,
      decoration: borderColor != null
          ? BoxDecoration(
              border: Border.all(
                color: borderColor ?? Colors.black,
              ),
              borderRadius: borderRadius ?? AppBorderRadius.sm)
          : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: textStyle,
            padding: padding,
            foregroundColor: foregroundColor ?? Colors.white,
            backgroundColor: backgroundColor ?? AppColors.primaryColor,
            disabledForegroundColor: disabledForegroundColor ?? Colors.white,
            disabledBackgroundColor: disabledBackgroundColor ??
                backgroundColor ??
                AppColors.primaryColor.o(0.5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? AppBorderRadius.sm,
              side: side ?? BorderSide.none,
            )),
        onPressed: disabled ? null : onPressed,
        child: child,
      ),
    );
  }
}
