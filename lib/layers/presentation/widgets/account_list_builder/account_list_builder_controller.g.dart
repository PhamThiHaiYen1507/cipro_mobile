// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountListBuilderController
    on _AccountListBuilderControllerBase, Store {
  late final _$accountsAtom = Atom(
      name: '_AccountListBuilderControllerBase.accounts', context: context);

  @override
  List<AccountInfoModel> get accounts {
    _$accountsAtom.reportRead();
    return super.accounts;
  }

  @override
  set accounts(List<AccountInfoModel> value) {
    _$accountsAtom.reportWrite(value, super.accounts, () {
      super.accounts = value;
    });
  }

  late final _$_getAccountListAsyncAction = AsyncAction(
      '_AccountListBuilderControllerBase._getAccountList',
      context: context);

  @override
  Future<void> _getAccountList() {
    return _$_getAccountListAsyncAction.run(() => super._getAccountList());
  }

  @override
  String toString() {
    return '''
accounts: ${accounts}
    ''';
  }
}
