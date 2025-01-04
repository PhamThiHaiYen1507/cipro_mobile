import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/layers/presentation/widgets/project_list_builder/project_list_builder.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

class SelectProjectDropdown extends StatelessWidget {
  final AccountRole role;
  final String? selectedProjectName;

  final void Function(ProjectInfoModel)? onSelected;

  const SelectProjectDropdown(
      {super.key,
      this.selectedProjectName,
      this.onSelected,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return ProjectListBuilder(
      onInitialize: (projects) {
        if (projects.isNotEmpty) onSelected?.call(projects.first);
      },
      builder: (projects) {
        return CustomDropdown(
          items: [
            ...projects,
            if (role == AccountRole.manager)
              ProjectInfoModel(
                name: "Add new project",
                phaseList: [],
                projectId: '-1',
                workflows: [],
              ),
          ],
          fitScreen: true,
          fitSize: true,
          selectedItem: projects.firstWhereOrNull(
              (element) => element.name == selectedProjectName),
          onSelected: onSelected,
          itemBuilder: (item) {
            return Padding(
              padding: AppPadding.a8,
              child: Row(
                children: [
                  item.projectId != '-1'
                      ? const Icon(Icons.event_note)
                      : const Icon(Icons.add),
                  Expanded(
                      child: TextMarqueeWidget(
                    child: Text(
                      item.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
