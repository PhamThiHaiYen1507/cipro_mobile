// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_list_builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TemplateListBuilderController
    on _TemplateListBuilderControllerBase, Store {
  late final _$templatesAtom = Atom(
      name: '_TemplateListBuilderControllerBase.templates', context: context);

  @override
  List<TemplateInfoModel> get templates {
    _$templatesAtom.reportRead();
    return super.templates;
  }

  @override
  set templates(List<TemplateInfoModel> value) {
    _$templatesAtom.reportWrite(value, super.templates, () {
      super.templates = value;
    });
  }

  late final _$fetchTemplateListAsyncAction = AsyncAction(
      '_TemplateListBuilderControllerBase.fetchTemplateList',
      context: context);

  @override
  Future<void> fetchTemplateList() {
    return _$fetchTemplateListAsyncAction.run(() => super.fetchTemplateList());
  }

  @override
  String toString() {
    return '''
templates: ${templates}
    ''';
  }
}
