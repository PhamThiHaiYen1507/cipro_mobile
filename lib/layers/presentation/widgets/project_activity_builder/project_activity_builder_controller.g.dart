// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activity_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectActivityBuilderController
    on _ProjectActivityBuilderControllerBase, Store {
  late final _$activitiesAtom = Atom(
      name: '_ProjectActivityBuilderControllerBase.activities',
      context: context);

  @override
  List<ProjectActivityInfoModel> get activities {
    _$activitiesAtom.reportRead();
    return super.activities;
  }

  @override
  set activities(List<ProjectActivityInfoModel> value) {
    _$activitiesAtom.reportWrite(value, super.activities, () {
      super.activities = value;
    });
  }

  late final _$_getProjectActivitiesAsyncAction = AsyncAction(
      '_ProjectActivityBuilderControllerBase._getProjectActivities',
      context: context);

  @override
  Future<void> _getProjectActivities() {
    return _$_getProjectActivitiesAsyncAction
        .run(() => super._getProjectActivities());
  }

  @override
  String toString() {
    return '''
activities: ${activities}
    ''';
  }
}
