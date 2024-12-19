import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class ImportProjectDialog extends StatelessWidget {
  final List<ProjectFromThirdPartyModel> projects;
  final ProjectFromThirdPartyModel? selectedProject;
  final Function(ProjectFromThirdPartyModel) onSelected;
  final VoidCallback onCancel;
  final VoidCallback onImport;

  const ImportProjectDialog({
    required this.projects,
    required this.selectedProject,
    required this.onSelected,
    required this.onCancel,
    required this.onImport,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Import project from Github/Gitlab',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            CustomDropdown<ProjectFromThirdPartyModel>(
              items: projects,
              fitScreen: true,
              fitSize: true,
              constraints: const BoxConstraints(maxHeight: 250),
              selectedItem: selectedProject,
              onSelected: (item) => onSelected(item),
              itemBuilder: (item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.folder, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: onImport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Import'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
