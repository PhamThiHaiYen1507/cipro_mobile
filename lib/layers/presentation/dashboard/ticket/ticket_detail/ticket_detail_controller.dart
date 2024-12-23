import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:mobx/mobx.dart';

part 'ticket_detail_controller.g.dart';

class TicketDetailController = _TicketDetailControllerBase
    with _$TicketDetailController;

abstract class _TicketDetailControllerBase with Store {
  final TicketRepository _ticketRepository;

  final String ticketId;

  _TicketDetailControllerBase(this._ticketRepository, this.ticketId);

  @observable
  ProjectMemberInfoModel? assignee;

  @action
  void onUpdateAssignee(ProjectMemberInfoModel item) {
    assignee = item;
  }

  Future<bool> updateTicket({String? status, String? assigneeId}) async {
    final res = await _ticketRepository.updateTicket(
        ticketId: ticketId, status: status, assigneeId: assigneeId);

    return res.fold((left) => false, (right) => true);
  }

  Future<bool> onAddResolution(String cveId, String resolution) async {
    final res = await _ticketRepository.addResolution(
        cveId: cveId, resolution: resolution);

    return res.fold((_) => false, (right) => true);
  }
}
