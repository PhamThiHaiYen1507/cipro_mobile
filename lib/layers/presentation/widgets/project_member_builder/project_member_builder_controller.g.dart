// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectMemberBuilderController
    on _ProjectMemberBuilderControllerBase, Store {
  late final _$membersAtom = Atom(
      name: '_ProjectMemberBuilderControllerBase.members', context: context);

  @override
  List<ProjectMemberInfoModel> get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(List<ProjectMemberInfoModel> value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  late final _$_getProjectMembersAsyncAction = AsyncAction(
      '_ProjectMemberBuilderControllerBase._getProjectMembers',
      context: context);

  @override
  Future<void> _getProjectMembers() {
    return _$_getProjectMembersAsyncAction
        .run(() => super._getProjectMembers());
  }

  @override
  String toString() {
    return '''
members: ${members}
    ''';
  }
}
