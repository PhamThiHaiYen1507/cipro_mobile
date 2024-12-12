import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/scanner_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'scanner_list_builder_controller.dart';

class ScannerListBuilder
    extends MobxStatefulWidget<ScannerListBuilderController> {
  const ScannerListBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(List<ScannerInfoModel>) builder;

  @override
  _ScannerListBuilderState createState() => _ScannerListBuilderState();
}

class _ScannerListBuilderState
    extends MobxState<ScannerListBuilder, ScannerListBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return widget.builder(controller.scanners);
    });
  }
}
