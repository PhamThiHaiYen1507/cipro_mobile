import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/threat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'threat_builder_controller.dart';

class ThreatBuilder extends MobxStatefulWidget<ThreatBuilderController> {
  final Widget Function(ThreatBuilderController c, List<ThreatModel> threats)
      builder;

  const ThreatBuilder({
    super.key,
    required this.builder,
  });

  @override
  _ThreatBuilderState createState() => _ThreatBuilderState();
}

class _ThreatBuilderState
    extends MobxState<ThreatBuilder, ThreatBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => widget.builder(controller, controller.threats),
    );
  }
}
