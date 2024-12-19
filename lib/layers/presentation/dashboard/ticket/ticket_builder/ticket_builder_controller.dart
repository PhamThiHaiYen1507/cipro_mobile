import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:mobx/mobx.dart';

part 'ticket_builder_controller.g.dart';

class TicketBuilderController = _TicketBuilderControllerBase
    with _$TicketBuilderController;

abstract class _TicketBuilderControllerBase with Store {
  final TicketRepository _ticketRepository;

  final String projectName;

  _TicketBuilderControllerBase(this._ticketRepository, this.projectName) {
    getTickets();
  }

  @observable
  List<TicketModel> tickets = [];

  @action
  Future<void> getTickets() async {
    final res = await _ticketRepository.getTickets(projectName);

    res.map((right) {
      if (right != null) tickets = right;
    });
  }
}
