import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';

abstract class PhaseRepository {
  Future<ApiResponseData<List<PhaseTemplateModel>?>> getTemplateList();

  Future<ApiResponseData<PhaseModel?>> getPhase(String phaseId);
}
