import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
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
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => const NotificationSettingsScreenRoute().push(context),
            child: Padding(
              padding: AppPadding.a16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.settings,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    'Notification settings',
                    style: AppTextStyle.f16B
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Observer(builder: (context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
          }),
        ),
      ],
    );
  }
}
