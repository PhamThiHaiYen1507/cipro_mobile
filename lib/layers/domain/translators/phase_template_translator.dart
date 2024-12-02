import 'package:base_project/layers/data/response/phase_template_response.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';
import 'package:base_project/layers/domain/translators/phase_translator.dart';
import 'package:base_project/utils/utils.dart';

extension PhaseTemplateTranslator on PhaseTemplateResponse {
  PhaseTemplateModel toPhaseTemplateModel() => PhaseTemplateModel(
      id: id ?? Utils.generateId,
      name: name ?? '',
      description: description ?? '',
      createdBy: createdBy ?? '',
      isPrivate: isPrivate ?? false,
      phases: phases?.map((e) => e.toPhaseModel()).toList() ?? []);
}
