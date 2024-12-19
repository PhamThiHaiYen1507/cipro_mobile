import 'package:base_project/layers/domain/entities/threat_model.dart';
import 'package:base_project/layers/domain/repositories/threat_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'threat_builder_controller.g.dart';

@injectable
class ThreatBuilderController = _ThreatBuilderControllerBase
    with _$ThreatBuilderController;

abstract class _ThreatBuilderControllerBase with Store {
  final ThreatRepository _threatRepository;

  _ThreatBuilderControllerBase(this._threatRepository) {
    getThreats();
  }

  @observable
  List<ThreatModel> threats = [];

  @action
  Future<void> getThreats() async {
    final res = await _threatRepository.getThreats();

    res.map((right) {
      threats = right;
    });
  }
}
