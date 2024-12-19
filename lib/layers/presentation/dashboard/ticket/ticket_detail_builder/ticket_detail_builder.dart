import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'ticket_detail_builder_controller.dart';

class TicketDetailBuilder
    extends MobxStatefulWidget<TicketDetailBuilderController> {
  final String ticketId;

  final Widget Function(
      TicketDetailBuilderController controller, TicketModel? ticket) builder;

  const TicketDetailBuilder(
      {super.key, required this.ticketId, required this.builder});

  @override
  _TicketDetailBuilderState createState() => _TicketDetailBuilderState();

  @override
  TicketDetailBuilderController? createController() =>
      TicketDetailBuilderController(injector(), ticketId);
}

class _TicketDetailBuilderState
    extends MobxState<TicketDetailBuilder, TicketDetailBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => widget.builder(controller, controller.ticket));
  }
}
