import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'ticket_builder_controller.dart';

class TicketBuilder extends MobxStatefulWidget<TicketBuilderController> {
  final String projectName;

  final Widget Function(
      TicketBuilderController controller, List<TicketModel> tickets) builder;

  const TicketBuilder(
      {super.key, required this.projectName, required this.builder})
      : super(tag: projectName);

  @override
  MobxState<MobxStatefulWidget<TicketBuilderController>,
      TicketBuilderController> createState() => _TicketBuilderState();

  @override
  TicketBuilderController? createController() =>
      TicketBuilderController(injector(), projectName);
}

class _TicketBuilderState
    extends MobxState<TicketBuilder, TicketBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => widget.builder(controller, controller.tickets));
  }
}
