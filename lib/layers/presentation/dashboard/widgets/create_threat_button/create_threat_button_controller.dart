import 'package:base_project/layers/domain/repositories/threat_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'create_threat_button_controller.g.dart';

@injectable
class CreateThreatButtonController = _CreateThreatButtonControllerBase
    with _$CreateThreatButtonController;

abstract class _CreateThreatButtonControllerBase with Store {
  final ThreatRepository _threatRepository;

  _CreateThreatButtonControllerBase(this._threatRepository);

  Future<bool> onCreateThreat({
    required String name,
    required String description,
    required String type,
    required double total,
    required int damage,
    required int reproducibility,
    required int exploitability,
    required int affectedUsers,
    required int discoverability,
  }) async {
    final res = await _threatRepository.createNewThreat(
      name: name,
      description: description,
      type: type,
      total: total,
      damage: damage,
      reproducibility: reproducibility,
      exploitability: exploitability,
      affectedUsers: affectedUsers,
      discoverability: discoverability,
    );

    return res.fold((left) => false, (right) => true);
  }
}
