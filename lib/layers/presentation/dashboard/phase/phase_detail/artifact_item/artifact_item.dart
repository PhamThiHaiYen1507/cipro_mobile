import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_artifact_button/create_artifact_button.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/state_manager/mobx_manager.dart';
import 'artifact_item_controller.dart';

class ArtifactItem extends MobxStatefulWidget<ArtifactItemController> {
  final String phaseId;

  final VoidCallback? onDeleteSuccess;

  final VoidCallback? onUpdateSuccess;

  const ArtifactItem({
    super.key,
    required this.artifact,
    required this.phaseId,
    this.onDeleteSuccess,
    this.onUpdateSuccess,
  });

  final ArtifactModel artifact;

  @override
  _ArtifactItemState createState() => _ArtifactItemState();
}

class _ArtifactItemState
    extends MobxState<ArtifactItem, ArtifactItemController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.a8,
      padding: AppPadding.a16,
      decoration: context.defaultBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.artifact.name,
            style: AppTextStyle.f18B,
          ),
          Text(widget.artifact.type.name),
          Row(
            children: [
              IconButton(
                onPressed: showEditArtifactForm,
                icon: const Icon(Icons.mode_edit_outlined),
              ),
              IconButton(
                onPressed: showDeletePopup,
                icon: const Icon(Icons.delete_outline_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showDeletePopup() {
    AppDialog.dialog(
      context: context,
      title: 'Delete artifact',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Are you sure you want to delete this artifact?'),
          AppSpacing.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                backgroundColor: AppColors.midGrey,
                onPressed: () => context.pop(),
                child: const Text('Cancel', style: AppTextStyle.f16B),
              ),
              Button(
                  onPressed: () async {
                    context.pop();

                    final res = await controller.deleteArtifact(
                        widget.phaseId, widget.artifact.id);

                    if (res) {
                      AppDialog.showNotification(
                        context: context,
                        message: 'Delete artifact success',
                        type: NotificationType.success,
                      );
                      widget.onDeleteSuccess?.call();
                    } else {
                      AppDialog.showNotification(
                        context: context,
                        message: 'Delete artifact failed',
                        type: NotificationType.error,
                      );
                    }
                  },
                  child: const Text('Delete')),
            ],
          )
        ],
      ),
    );
  }

  void showEditArtifactForm() {
    AppDialog.dialog(
      context: context,
      insetPadding: AppPadding.a16,
      title: 'Update artifact',
      content: CreateArtifactForm(
        name: widget.artifact.name,
        url: widget.artifact.url,
        version: widget.artifact.version,
        cpe: widget.artifact.cpe,
        onCancel: context.pop,
        isUpdate: true,
        onCreate: (name, url, version, cpe, type) async {
          final res = await controller.updateArtifact(
              artifactId: widget.artifact.id,
              name: name,
              url: url,
              version: version,
              cpe: cpe,
              type: type);

          context.pop();

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Update artifact success',
              type: NotificationType.success,
            );
            widget.onUpdateSuccess?.call();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Update artifact failed',
              type: NotificationType.error,
            );
          }
        },
      ),
    );
  }
}
