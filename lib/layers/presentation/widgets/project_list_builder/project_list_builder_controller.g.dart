// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectListBuilderController
    on _ProjectListBuilderControllerBase, Store {
  late final _$projectsAtom = Atom(
      name: '_ProjectListBuilderControllerBase.projects', context: context);

  @override
  List<ProjectInfoModel> get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(List<ProjectInfoModel> value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$_getProjectsAsyncAction = AsyncAction(
      '_ProjectListBuilderControllerBase._getProjects',
      context: context);

  @override
  Future<void> _getProjects() {
    return _$_getProjectsAsyncAction.run(() => super._getProjects());
  }

  @override
  String toString() {
    return '''
projects: ${projects}
    ''';
  }
}
