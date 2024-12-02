import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'phase_builder_controller.dart';

class PhaseBuilder extends MobxStatefulWidget<PhaseBuilderController> {
  final String phaseId;

  final Widget Function(PhaseModel? phase) builder;

  const PhaseBuilder({
    super.key,
    required this.phaseId,
    required this.builder,
  }) : super(tag: phaseId);

  @override
  MobxState<MobxStatefulWidget<PhaseBuilderController>, PhaseBuilderController>
      createState() => _PhaseBuilderState();

  @override
  PhaseBuilderController? createController() =>
      PhaseBuilderController(injector(), phaseId);
}

class _PhaseBuilderState
    extends MobxState<PhaseBuilder, PhaseBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => widget.builder(controller.phase));
  }
}
