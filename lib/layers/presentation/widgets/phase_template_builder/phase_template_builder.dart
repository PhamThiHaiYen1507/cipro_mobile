import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'phase_template_builder_controller.dart';

class PhaseTemplateBuilder
    extends MobxStatefulWidget<PhaseTemplateBuilderController> {
  final Widget Function(PhaseTemplateBuilderController controller,
      List<PhaseTemplateModel> templates) builder;

  const PhaseTemplateBuilder({
    super.key,
    required this.builder,
  });

  @override
  _PhaseTemplateBuilderState createState() => _PhaseTemplateBuilderState();
}

class _PhaseTemplateBuilderState
    extends MobxState<PhaseTemplateBuilder, PhaseTemplateBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller, controller.templates),
    );
  }
}
