import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/template_info_model.dart';

abstract class TemplateInfoRepository {
  Future<ApiResponseData<List<TemplateInfoModel>?>> getTemplateList();
}
