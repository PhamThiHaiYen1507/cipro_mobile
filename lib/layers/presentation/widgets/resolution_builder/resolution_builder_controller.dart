import 'package:base_project/layers/domain/entities/resolution_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:mobx/mobx.dart';

part 'resolution_builder_controller.g.dart';

class ResolutionBuilderController = _ResolutionBuilderControllerBase
    with _$ResolutionBuilderController;

abstract class _ResolutionBuilderControllerBase with Store {
  final TicketRepository _ticketRepository;

  final List<String> cveIds;

  @observable
  List<ResolutionModel> resolutions = [];

  _ResolutionBuilderControllerBase(this._ticketRepository, this.cveIds) {
    getResolution();
  }

  @action
  Future<void> getResolution() async {
    final res = await _ticketRepository.getResolution(cveIds: cveIds);

    res.map((right) {
      resolutions = right;
    });
  }
}
