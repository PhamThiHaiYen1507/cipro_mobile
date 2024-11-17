import 'package:another_flushbar/flushbar.dart';
import 'package:base_project/core/extensions/number_extension.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppDialog {
  static Future<T?> bottomSheet<T>({
    required BuildContext context,
    required Widget child,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
    BorderRadiusGeometry? borderRadius,
    bool avoidKeyboard = false,
  }) {
    return showModalBottomSheet(
      backgroundColor: AppColors.background,
      isDismissible: isDismissible,
      context: context,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: RouteSettings(
        name: 'APP_DIALOG_${DateTime.now().millisecondsSinceEpoch}',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppBorderRadius.xlTop,
      ),
      isScrollControlled: isScrollControlled,
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        if (avoidKeyboard) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.a8,
                  Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: 5.radius,
                              color: AppColors.midGrey.withOpacity(0.5)),
                          width: 36,
                          height: 5)),
                  AppSpacing.h4,
                  Flexible(child: child),
                ]),
          );
        }

        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.a8,
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: 5.radius,
                            color: AppColors.midGrey.withOpacity(0.5)),
                        width: 36,
                        height: 5)),
                AppSpacing.h4,
                Flexible(child: child),
              ]),
        );
      },
    );
  }

  static Future<T?> dialog<T>({
    required BuildContext context,
    Widget? content,
    double? radius,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsets? insetPadding,
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      routeSettings: RouteSettings(
        name: 'APP_DIALOG_${DateTime.now().millisecondsSinceEpoch}',
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: barrierDismissible,
          child: AlertDialog(
            insetPadding:
                insetPadding ?? const EdgeInsets.symmetric(vertical: 18),
            contentPadding: contentPadding ?? 18.padding,
            content: content,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
          ),
        );
      },
    );
  }

  static void showNotification({
    required BuildContext context,
    required String title,
    required String message,
    required NotificationType type,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Flushbar(
        messageText: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SvgView(type.icon),
            // AppSpacing.w4,
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: AppTextStyle.f16B,
                    ),
                  AppSpacing.h4,
                  Text(
                    message,
                    style: AppTextStyle.f16R,
                  )
                ])),
            GestureDetector(
                onTap: context.pop,
                child: const Icon(
                  Icons.close,
                ))
          ],
        ),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadows: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.8),
            blurRadius: 4,
          ),
        ],
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.white,
        isDismissible: true,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
        showProgressIndicator: false,
        progressIndicatorBackgroundColor: Colors.white,
      ).show(context);
    });
  }
}
