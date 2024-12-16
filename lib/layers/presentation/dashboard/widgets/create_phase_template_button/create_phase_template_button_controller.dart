import 'package:base_project/layers/domain/repositories/phase_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/phase_model.dart';

part 'create_phase_template_button_controller.g.dart';

@injectable
class CreatePhaseTemplateButtonController = _CreatePhaseTemplateButtonControllerBase
    with _$CreatePhaseTemplateButtonController;

abstract class _CreatePhaseTemplateButtonControllerBase with Store {
  final PhaseRepository _phaseRepository;

  _CreatePhaseTemplateButtonControllerBase(this._phaseRepository);

  Future<bool> onCreateNewPhaseTemplate({
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  }) async {
    final res = await _phaseRepository.createPhaseTemplate(
        name: name,
        description: description,
        isPrivate: isPrivate,
        phases: phases);

    return res.fold((left) => false, (right) => true);
  }

  Future<bool> onUpdatePhaseTemplate({
    required String templateId,
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  }) async {
    final res = await _phaseRepository.updatePhaseTemplate(
      templateId: templateId,
      name: name,
      description: description,
      isPrivate: isPrivate,
      phases: phases,
    );

    return res.fold((left) => false, (right) => true);
  }
}
