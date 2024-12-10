import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountDialog extends StatelessWidget {
  final Function() onDelete;
  const DeleteAccountDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
                child: Text('Are you sure you want to delete this account?')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  backgroundColor: AppColors.midGrey,
                  onPressed: () => context.pop(),
                  child: const Text('Cancel', style: AppTextStyle.f16B),
                ),
                Button(onPressed: onDelete, child: const Text('Delete')),
              ],
            ),
          ],
        ));
  }
}
