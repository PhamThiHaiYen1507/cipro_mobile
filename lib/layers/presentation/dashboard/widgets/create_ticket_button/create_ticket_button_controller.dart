import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/vulnerability_model.dart';

part 'create_ticket_button_controller.g.dart';

@injectable
class CreateTicketButtonController = _CreateTicketButtonControllerBase
    with _$CreateTicketButtonController;

abstract class _CreateTicketButtonControllerBase with Store {
  final TicketRepository _ticketRepository;

  _CreateTicketButtonControllerBase(this._ticketRepository);

  Future<bool> onCreateTicket({
    String? assigneeId,
    String? description,
    String? priority,
    String? projectName,
    List<VulnerabilityModel> targetedVulnerability = const [],
    String? title,
  }) async {
    final res = await _ticketRepository.createTicket(
      assigneeId: assigneeId,
      description: description,
      priority: priority,
      projectName: projectName,
      targetedVulnerability: targetedVulnerability,
      title: title,
    );

    return res.fold((left) => false, (right) => true);
  }
}
