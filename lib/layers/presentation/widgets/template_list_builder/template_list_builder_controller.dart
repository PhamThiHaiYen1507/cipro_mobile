import 'package:base_project/layers/domain/entities/template_info_model.dart';
import 'package:base_project/layers/domain/repositories/template_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'template_list_builder_controller.g.dart';

@injectable
class TemplateListBuilderController = _TemplateListBuilderControllerBase
    with _$TemplateListBuilderController;

abstract class _TemplateListBuilderControllerBase with Store {
  final TemplateInfoRepository _templateInfoRepository;

  _TemplateListBuilderControllerBase(this._templateInfoRepository);

  @observable
  List<TemplateInfoModel> templates = [];

  @action
  Future<void> fetchTemplateList() async {
    final res = await _templateInfoRepository.getTemplateList();

    res.map((right) {
      if (right != null) templates = right;
    });
  }
}
