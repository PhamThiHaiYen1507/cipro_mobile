import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:mobx/mobx.dart';

part 'ticket_history_builder_controller.g.dart';

class TicketHistoryBuilderController = _TicketHistoryBuilderControllerBase
    with _$TicketHistoryBuilderController;

abstract class _TicketHistoryBuilderControllerBase with Store {
  final TicketRepository _ticketRepository;

  final String ticketId;

  _TicketHistoryBuilderControllerBase(this._ticketRepository, this.ticketId) {
    getHistories();
  }

  @observable
  List<ActivityHistoryInfoModel> histories = [];

  @action
  Future<void> getHistories() async {
    final res = await _ticketRepository.getTicketHistory(ticketId);

    res.map((right) {
      if (right != null) histories = right;
    });
  }
}
