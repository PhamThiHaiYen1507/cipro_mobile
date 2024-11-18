// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectBuilderController on _ProjectBuilderControllerBase, Store {
  late final _$projectAtom =
      Atom(name: '_ProjectBuilderControllerBase.project', context: context);

  @override
  ProjectInfoModel? get project {
    _$projectAtom.reportRead();
    return super.project;
  }

  @override
  set project(ProjectInfoModel? value) {
    _$projectAtom.reportWrite(value, super.project, () {
      super.project = value;
    });
  }

  late final _$_getProjectInfoAsyncAction = AsyncAction(
      '_ProjectBuilderControllerBase._getProjectInfo',
      context: context);

  @override
  Future<void> _getProjectInfo() {
    return _$_getProjectInfoAsyncAction.run(() => super._getProjectInfo());
  }

  @override
  String toString() {
    return '''
project: ${project}
    ''';
  }
}
