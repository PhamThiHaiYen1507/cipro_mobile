// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_workflow_list_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectWorkflowListBuilderController
    on _ProjectWorkflowListBuilderControllerBase, Store {
  late final _$workflowsAtom = Atom(
      name: '_ProjectWorkflowListBuilderControllerBase.workflows',
      context: context);

  @override
  List<WorkflowInfoModel> get workflows {
    _$workflowsAtom.reportRead();
    return super.workflows;
  }

  @override
  set workflows(List<WorkflowInfoModel> value) {
    _$workflowsAtom.reportWrite(value, super.workflows, () {
      super.workflows = value;
    });
  }

  late final _$_getWorkflowsAsyncAction = AsyncAction(
      '_ProjectWorkflowListBuilderControllerBase._getWorkflows',
      context: context);

  @override
  Future<void> _getWorkflows() {
    return _$_getWorkflowsAsyncAction.run(() => super._getWorkflows());
  }

  @override
  String toString() {
    return '''
workflows: ${workflows}
    ''';
  }
}
