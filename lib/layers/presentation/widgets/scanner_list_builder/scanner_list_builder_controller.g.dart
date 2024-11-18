// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_list_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScannerListBuilderController
    on _ScannerListBuilderControllerBase, Store {
  late final _$scannersAtom = Atom(
      name: '_ScannerListBuilderControllerBase.scanners', context: context);

  @override
  List<ScannerInfoModel> get scanners {
    _$scannersAtom.reportRead();
    return super.scanners;
  }

  @override
  set scanners(List<ScannerInfoModel> value) {
    _$scannersAtom.reportWrite(value, super.scanners, () {
      super.scanners = value;
    });
  }

  late final _$_fetchScannerListAsyncAction = AsyncAction(
      '_ScannerListBuilderControllerBase._fetchScannerList',
      context: context);

  @override
  Future<void> _fetchScannerList() {
    return _$_fetchScannerListAsyncAction.run(() => super._fetchScannerList());
  }

  @override
  String toString() {
    return '''
scanners: ${scanners}
    ''';
  }
}
