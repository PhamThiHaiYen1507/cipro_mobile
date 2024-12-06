import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/dashboard/account/dashboard_account_controller.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog
    extends MobxStatefulWidget<DashboardAccountController> {
  const DeleteAccountDialog({super.key});

  @override
  MobxState<MobxStatefulWidget<DashboardAccountController>,
      DashboardAccountController> createState() => _EditAccountDialogState();
}

class _EditAccountDialogState
    extends MobxState<DeleteAccountDialog, DashboardAccountController> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Delete Account'),
        Button(
            onPressed: () => controller.deleteAccount(context),
            child: const Text('Delete'))
      ],
    ));
  }
}
