// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivityHistoryBuilderController
    on _ActivityHistoryBuilderControllerBase, Store {
  late final _$historiesAtom = Atom(
      name: '_ActivityHistoryBuilderControllerBase.histories',
      context: context);

  @override
  List<ActivityHistoryInfoModel> get histories {
    _$historiesAtom.reportRead();
    return super.histories;
  }

  @override
  set histories(List<ActivityHistoryInfoModel> value) {
    _$historiesAtom.reportWrite(value, super.histories, () {
      super.histories = value;
    });
  }

  late final _$_getHistoriesAsyncAction = AsyncAction(
      '_ActivityHistoryBuilderControllerBase._getHistories',
      context: context);

  @override
  Future _getHistories() {
    return _$_getHistoriesAsyncAction.run(() => super._getHistories());
  }

  @override
  String toString() {
    return '''
histories: ${histories}
    ''';
  }
}
