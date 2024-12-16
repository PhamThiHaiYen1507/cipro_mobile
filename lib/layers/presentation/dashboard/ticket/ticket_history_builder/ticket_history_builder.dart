import 'package:base_project/core/di/injector.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/state_manager/mobx_manager.dart';
import 'ticket_history_builder_controller.dart';

class TicketHistoryBuilder
    extends MobxStatefulWidget<TicketHistoryBuilderController> {
  final String ticketId;

  final Widget Function(TicketHistoryBuilderController controller,
      List<ActivityHistoryInfoModel> histories) builder;
  const TicketHistoryBuilder(
      {super.key, required this.ticketId, required this.builder});

  @override
  _TicketHistoryBuilderState createState() => _TicketHistoryBuilderState();

  @override
  TicketHistoryBuilderController? createController() =>
      TicketHistoryBuilderController(injector(), ticketId);
}

class _TicketHistoryBuilderState
    extends MobxState<TicketHistoryBuilder, TicketHistoryBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => widget.builder(controller, controller.histories));
  }
}
