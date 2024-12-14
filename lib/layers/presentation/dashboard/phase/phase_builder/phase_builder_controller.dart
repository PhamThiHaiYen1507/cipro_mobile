import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/repositories/phase_repository.dart';
import 'package:mobx/mobx.dart';

part 'phase_builder_controller.g.dart';

class PhaseBuilderController = _PhaseBuilderControllerBase
    with _$PhaseBuilderController;

abstract class _PhaseBuilderControllerBase with Store {
  final PhaseRepository _phaseRepository;

  final String phaseId;

  _PhaseBuilderControllerBase(this._phaseRepository, this.phaseId) {
    getPhase();
  }

  @observable
  PhaseModel? phase;

  @action
  Future<void> getPhase() async {
    final res = await _phaseRepository.getPhase(phaseId);

    res.map((right) {
      if (right != null) phase = right;
    });
  }
}
