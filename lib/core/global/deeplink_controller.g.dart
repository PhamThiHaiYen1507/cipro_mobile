// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deeplink_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeeplinkController on _DeeplinkControllerBase, Store {
  late final _$deeplinkAtom =
      Atom(name: '_DeeplinkControllerBase.deeplink', context: context);

  @override
  Uri? get deeplink {
    _$deeplinkAtom.reportRead();
    return super.deeplink;
  }

  @override
  set deeplink(Uri? value) {
    _$deeplinkAtom.reportWrite(value, super.deeplink, () {
      super.deeplink = value;
    });
  }

  @override
  String toString() {
    return '''
deeplink: ${deeplink}
    ''';
  }
}
