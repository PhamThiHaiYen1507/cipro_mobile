import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:flutter/material.dart';

import 'delete_member_project_button_controller.dart';

class DeleteMemberProjectButton
    extends MobxStatefulWidget<DeleteMemberProjectButtonController> {
  final String projectName;

  final String accountId;

  final void Function() onRemoveSuccess;

  const DeleteMemberProjectButton({
    super.key,
    required this.projectName,
    required this.accountId,
    required this.onRemoveSuccess,
  });

  @override
  _DeleteMemberProjectButtonState createState() =>
      _DeleteMemberProjectButtonState();
}

class _DeleteMemberProjectButtonState extends MobxState<
    DeleteMemberProjectButton, DeleteMemberProjectButtonController> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller
          .removeMember(widget.projectName, widget.accountId)
          .then((_) => widget.onRemoveSuccess()),
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
