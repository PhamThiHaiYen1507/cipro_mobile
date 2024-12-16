import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'activity_history_builder_controller.dart';

class ActivityHistoryBuilder
    extends MobxStatefulWidget<ActivityHistoryBuilderController> {
  final Widget Function(List<ActivityHistoryInfoModel> histories) builder;

  const ActivityHistoryBuilder({
    super.key,
    required this.builder,
  });

  @override
  _ActivityHistoryBuilderState createState() => _ActivityHistoryBuilderState();
}

class _ActivityHistoryBuilderState extends MobxState<ActivityHistoryBuilder,
    ActivityHistoryBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return widget.builder(controller.histories);
      },
    );
  }
}
