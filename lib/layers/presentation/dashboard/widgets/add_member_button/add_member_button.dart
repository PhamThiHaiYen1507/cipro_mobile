import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/widgets/all_user_builder/all_user_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/state_manager/mobx_manager.dart';
import '../../../../../utils/helpers/app_spacing.dart';
import '../../../../domain/entities/project_member_info_model.dart';
import '../../../widgets/custom_dropdown/custom_dropdown.dart';
import 'add_member_button_controller.dart';

class AddMemberButton extends MobxStatefulWidget<AddMemberButtonController> {
  final String projectName;

  final VoidCallback? onAddSuccess;

  const AddMemberButton(
      {super.key, this.onAddSuccess, required this.projectName});

  @override
  _AddMemberButtonState createState() => _AddMemberButtonState();
}

class _AddMemberButtonState
    extends MobxState<AddMemberButton, AddMemberButtonController> {
  final ValueNotifier<ProjectMemberInfoModel?> selectedUser =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showAddMemberPopup,
      child: Row(
        children: [
          const Icon(Icons.add, color: AppColors.purple),
          Text('Add member',
              style: AppTextStyle.f16M.copyWith(color: AppColors.purple)),
        ],
      ),
    );
  }

  void showAddMemberPopup() {
    AppDialog.dialog(
      context: context,
      title: 'Add a member',
      insetPadding: AppPadding.a16,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AllUserBuilder(
              builder: (members) {
                return ValueListenableBuilder(
                  valueListenable: selectedUser,
                  builder: (context, value, child) =>
                      CustomDropdown<ProjectMemberInfoModel>(
                    items: members,
                    fitSize: true,
                    useExpand: true,
                    placeHolderBuilder: () => Padding(
                      padding: AppPadding.h8,
                      child: Text(
                        'User',
                        style: AppTextStyle.f16R.copyWith(color: Colors.grey),
                      ),
                    ),
                    itemBuilder: (item) =>
                        item.account?.username.isNotEmpty == true
                            ? Container(
                                width: double.maxFinite,
                                padding: AppPadding.a8,
                                child: Text(
                                  item.account?.username ?? '',
                                ),
                              )
                            : const SizedBox(),
                    selectedItem: value,
                    onSelected: (item) => selectedUser.value = item,
                  ),
                );
              },
            ),
            AppSpacing.h16,
            Row(
              children: [
                Expanded(
                  child: Button(
                    backgroundColor: Colors.red,
                    onPressed: context.pop,
                    child: const Text('Cancel'),
                  ),
                ),
                AppSpacing.w16,
                Expanded(
                  child: Button(
                    onPressed: () async {
                      context.pop();

                      final result = await controller.onAddUserToProject(
                          widget.projectName,
                          selectedUser.value?.account?.accountId ?? '');

                      if (result) {
                        AppDialog.showNotification(
                          context: context,
                          message: 'Add member success',
                          type: NotificationType.success,
                        );
                        widget.onAddSuccess?.call();
                      } else {
                        AppDialog.showNotification(
                          context: context,
                          message: 'Add member failed',
                          type: NotificationType.error,
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    selectedUser.dispose();
    super.dispose();
  }
}
