import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/state_manager/mobx_manager.dart';
import 'notification_settings_controller.dart';

enum NotificationSettingType {
  ticket('Receive notifications from tickets'),
  task('Receive notifications from tasks'),
  workflow('Receive notifications from workflows'),
  vulnerability('Receive notifications when vulnerabilities are detected');

  final String title;

  const NotificationSettingType(this.title);
}

class NotificationSettingsScreen
    extends MobxStatefulWidget<NotificationSettingsController> {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends MobxState<
    NotificationSettingsScreen, NotificationSettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: AppPadding.a8,
        itemCount: NotificationSettingType.values.length,
        itemBuilder: (context, index) {
          final type = NotificationSettingType.values[index];

          return Padding(
            padding: AppPadding.a8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    type.title,
                    style: AppTextStyle.f14B,
                  ),
                ),
                Observer(builder: (context) {
                  return Switch(
                    value: controller.notifications.contains(type.name),
                    onChanged: (value) {
                      if (value) {
                        controller.onAddNotificationSetting(type.name);
                      } else {
                        controller.onRemoveNotificationSetting(type.name);
                      }
                    },
                  );
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
