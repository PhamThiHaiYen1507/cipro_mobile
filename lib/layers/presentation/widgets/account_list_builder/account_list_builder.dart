import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'account_list_builder_controller.dart';

class AccountListBuilder
    extends MobxStatefulWidget<AccountListBuilderController> {
  final Widget Function(List<AccountInfoModel> accounts) builder;

  const AccountListBuilder({
    super.key,
    required this.builder,
  });

  @override
  MobxState<MobxStatefulWidget<AccountListBuilderController>,
      AccountListBuilderController> createState() => _AccountListBuilderState();
}

class _AccountListBuilderState
    extends MobxState<AccountListBuilder, AccountListBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => widget.builder(controller.accounts));
  }
}
