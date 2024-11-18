// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardController on _DashboardControllerBase, Store {
  late final _$selectedProjectNameAtom = Atom(
      name: '_DashboardControllerBase.selectedProjectName', context: context);

  @override
  String? get selectedProjectName {
    _$selectedProjectNameAtom.reportRead();
    return super.selectedProjectName;
  }

  @override
  set selectedProjectName(String? value) {
    _$selectedProjectNameAtom.reportWrite(value, super.selectedProjectName, () {
      super.selectedProjectName = value;
    });
  }

  late final _$_DashboardControllerBaseActionController =
      ActionController(name: '_DashboardControllerBase', context: context);

  @override
  void setSelectedProjectName(
      BuildContext context, String current, String? name) {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.setSelectedProjectName');
    try {
      return super.setSelectedProjectName(context, current, name);
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedProjectName: ${selectedProjectName}
    ''';
  }
}
