import 'package:base_project/layers/domain/repositories/phase_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_template_controller.g.dart';

@injectable
class DashboardTemplateController = _DashboardTemplateControllerBase
    with _$DashboardTemplateController;

abstract class _DashboardTemplateControllerBase with Store {
  final PhaseRepository _phaseRepository;

  _DashboardTemplateControllerBase(this._phaseRepository);

  Future<bool> onDeletePhaseTemplate(String templateId) async {
    final res = await _phaseRepository.deletePhaseTemplate(templateId);

    return res.fold((left) => false, (right) => true);
  }
}
