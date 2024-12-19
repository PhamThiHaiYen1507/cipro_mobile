import 'package:base_project/layers/domain/entities/phase_template_model.dart';
import 'package:base_project/layers/domain/repositories/phase_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'phase_template_builder_controller.g.dart';

@injectable
class PhaseTemplateBuilderController = _PhaseTemplateBuilderControllerBase
    with _$PhaseTemplateBuilderController;

abstract class _PhaseTemplateBuilderControllerBase with Store {
  final PhaseRepository _phaseRepository;

  _PhaseTemplateBuilderControllerBase(this._phaseRepository) {
    fetchTemplateList();
  }

  @observable
  List<PhaseTemplateModel> templates = [];

  @action
  Future<void> fetchTemplateList() async {
    final res = await _phaseRepository.getTemplateList();

    res.map((right) {
      if (right != null) templates = right;
    });
  }
}
