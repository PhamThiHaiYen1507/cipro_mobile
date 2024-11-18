import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/template_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'template_list_builder_controller.dart';

class TemplateListBuilder
    extends MobxStatefulWidget<TemplateListBuilderController> {
  final Widget Function(List<TemplateInfoModel> templates) builder;

  const TemplateListBuilder({
    super.key,
    required this.builder,
  });

  @override
  _TemplateListBuilderState createState() => _TemplateListBuilderState();
}

class _TemplateListBuilderState
    extends MobxState<TemplateListBuilder, TemplateListBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller.templates),
    );
  }
}
