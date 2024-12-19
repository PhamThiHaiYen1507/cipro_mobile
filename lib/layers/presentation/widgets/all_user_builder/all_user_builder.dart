import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/state_manager/mobx_manager.dart';
import 'all_user_builder_controller.dart';

class AllUserBuilder extends MobxStatefulWidget<AllUserbuilderController> {
  final Widget Function(List<ProjectMemberInfoModel> users) builder;
  const AllUserBuilder({super.key, required this.builder});

  @override
  _AllUserBuilderState createState() => _AllUserBuilderState();
}

class _AllUserBuilderState
    extends MobxState<AllUserBuilder, AllUserbuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => widget.builder(controller.users));
  }
}
