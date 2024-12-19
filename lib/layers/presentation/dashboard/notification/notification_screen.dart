import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'notification_controller.dart';

class DashboardNotificationScreen
    extends MobxStatefulWidget<NotificationScreenController> {
  const DashboardNotificationScreen({super.key});

  @override
  _DashboardNotificationScreenState createState() =>
      _DashboardNotificationScreenState();
}

class _DashboardNotificationScreenState extends MobxState<
    DashboardNotificationScreen, NotificationScreenController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ListView.separated(
        padding: AppPadding.a16,
        separatorBuilder: (context, index) => AppSpacing.h8,
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {
          final notification = controller.notifications[index];

          return Container(
            decoration: context.defaultBox,
            padding: AppPadding.a16,
            child: Column(
              children: [
                Text(
                  notification.title,
                  style: AppTextStyle.f16B,
                ),
                AppSpacing.h8,
                Text(notification.content),
              ],
            ),
          );
        },
      );
    });
  }
}
