import 'package:base_project/layers/data/response/phase_response.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/translators/artifact_translator.dart';
import 'package:base_project/layers/domain/translators/task_info_translator.dart';
import 'package:base_project/utils/utils.dart';

extension PhaseTranslator on PhaseResponse {
  PhaseModel toPhaseModel() => PhaseModel(
        id: id ?? Utils.generateId,
        name: name ?? '',
        description: description ?? '',
        order: order ?? 0,
        createdAt: createdAt ?? DateTime.now(),
        updatedAt: updatedAt,
        artifacts: artifacts?.map((e) => e.toArtifactModel()).toList() ?? [],
        tasks: tasks?.map((e) => e.toTaskInfoModel()).toList() ?? [],
      );
}
