import 'package:flutter/material.dart';

import '../../../../core/state_manager/mobx_manager.dart';
import 'scan_activity_builder_controller.dart';

class ScanActivityBuilder
    extends MobxStatefulWidget<ScanActivityBuilderController> {
  const ScanActivityBuilder({super.key});

  @override
  _ScanActivityBuilderState createState() => _ScanActivityBuilderState();

  @override
  ScanActivityBuilderController? createController() =>
      ScanActivityBuilderController();
}

class _ScanActivityBuilderState
    extends MobxState<ScanActivityBuilder, ScanActivityBuilderController> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
