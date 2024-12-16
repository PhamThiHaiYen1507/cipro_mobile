import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:mobx/mobx.dart';

part 'ticket_detail_builder_controller.g.dart';

class TicketDetailBuilderController = _TicketDetailBuilderControllerBase
    with _$TicketDetailBuilderController;

abstract class _TicketDetailBuilderControllerBase with Store {
  final TicketRepository _ticketRepository;

  final String ticketId;

  _TicketDetailBuilderControllerBase(this._ticketRepository, this.ticketId) {
    getTicket();
  }

  @observable
  TicketModel? ticket;

  @action
  Future<void> getTicket() async {
    final res = await _ticketRepository.getTicket(ticketId);

    res.map((right) {
      ticket = right;
    });
  }
}
