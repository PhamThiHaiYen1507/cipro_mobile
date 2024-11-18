// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_manager_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountManagerController on _AccountManagerControllerBase, Store {
  late final _$accountInfoAtom =
      Atom(name: '_AccountManagerControllerBase.accountInfo', context: context);

  @override
  AccountInfoModel? get accountInfo {
    _$accountInfoAtom.reportRead();
    return super.accountInfo;
  }

  @override
  set accountInfo(AccountInfoModel? value) {
    _$accountInfoAtom.reportWrite(value, super.accountInfo, () {
      super.accountInfo = value;
    });
  }

  late final _$getAccountInfoAsyncAction = AsyncAction(
      '_AccountManagerControllerBase.getAccountInfo',
      context: context);

  @override
  Future<void> getAccountInfo() {
    return _$getAccountInfoAsyncAction.run(() => super.getAccountInfo());
  }

  @override
  String toString() {
    return '''
accountInfo: ${accountInfo}
    ''';
  }
}
