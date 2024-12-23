import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';

abstract class PhaseRepository {
  Future<ApiResponseData<List<PhaseTemplateModel>?>> getTemplateList();

  Future<ApiResponseData<PhaseModel?>> getPhase(String phaseId);

  Future<ApiResponseData<bool>> deletePhaseTemplate(String templateId);

  Future<ApiResponseData<bool>> createPhaseTemplate({
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  });

  Future<ApiResponseData<bool>> updatePhaseTemplate({
    required String templateId,
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  });

  Future<ApiResponseData<bool>> createPhaseFromTemplate({
    required String projectName,
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
    String? templateId,
  });
}
