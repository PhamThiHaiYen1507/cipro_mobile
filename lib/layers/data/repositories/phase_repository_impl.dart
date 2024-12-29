import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/phase_response.dart';
import 'package:base_project/layers/data/response/phase_template_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';
import 'package:base_project/layers/domain/repositories/phase_repository.dart';
import 'package:base_project/layers/domain/translators/phase_template_translator.dart';
import 'package:base_project/layers/domain/translators/phase_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: PhaseRepository)
class PhaseRepositoryImpl implements PhaseRepository {
  final ApiClient _client;

  PhaseRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<PhaseTemplateModel>?>> getTemplateList() async {
    try {
      final res = await _client.getTemplates();

      return Right(res
          .getItems(PhaseTemplateResponse.fromJson)
          ?.map((e) => e.toPhaseTemplateModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<PhaseModel?>> getPhase(String phaseId) async {
    try {
      final res = await _client.getPhase(phaseId);

      return Right(res.getBody(PhaseResponse.fromJson)?.toPhaseModel());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> deletePhaseTemplate(String templateId) async {
    try {
      await _client.deleteTemplate(templateId);

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> createPhaseTemplate({
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  }) async {
    try {
      await _client.createPhaseTemplate({
        "data": {
          "name": name,
          "description": description,
          "isPrivate": isPrivate,
          "phases": phases
              .map((e) => {
                    "name": e.name,
                    "description": e.description,
                    "order": e.order
                  })
              .toList(),
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> createPhaseFromTemplate({
    required String projectName,
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
    String? templateId,
  }) async {
    try {
      await _client.createPhaseFromTemplate({
        "projectName": projectName,
        "data": {
          "_id": templateId,
          "name": name,
          "description": description,
          "isPrivate": isPrivate,
          "phases": phases
              .map((e) => {
                    "name": e.name,
                    "description": e.description,
                    "order": e.order
                  })
              .toList(),
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> updatePhaseTemplate({
    required String templateId,
    required String name,
    required String description,
    required bool isPrivate,
    required List<PhaseModel> phases,
  }) async {
    try {
      await _client.updatePhaseTemplate(templateId, {
        "data": {
          "name": name,
          "description": description,
          "isPrivate": isPrivate,
          "phases": phases
              .map((e) => {
                    "name": e.name,
                    "description": e.description,
                    "order": e.order
                  })
              .toList(),
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
