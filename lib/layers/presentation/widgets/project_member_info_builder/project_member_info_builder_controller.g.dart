// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member_info_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectMemberInfoBuilderController
    on _ProjectMemberInfoBuilderControllerBase, Store {
  late final _$memberAtom = Atom(
      name: '_ProjectMemberInfoBuilderControllerBase.member', context: context);

  @override
  ProjectMemberInfoModel? get member {
    _$memberAtom.reportRead();
    return super.member;
  }

  @override
  set member(ProjectMemberInfoModel? value) {
    _$memberAtom.reportWrite(value, super.member, () {
      super.member = value;
    });
  }

  late final _$_getProjectMemberFromIdAsyncAction = AsyncAction(
      '_ProjectMemberInfoBuilderControllerBase._getProjectMemberFromId',
      context: context);

  @override
  Future<void> _getProjectMemberFromId() {
    return _$_getProjectMemberFromIdAsyncAction
        .run(() => super._getProjectMemberFromId());
  }

  @override
  String toString() {
    return '''
member: ${member}
    ''';
  }
}
