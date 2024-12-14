import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/artifact_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:base_project/layers/domain/repositories/artifact_repository.dart';
import 'package:base_project/layers/domain/translators/artifact_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ArtifactRepository)
class ArtifactRepositoryImpl implements ArtifactRepository {
  final ApiClient _client;

  ArtifactRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<ArtifactModel>?>> getArtifacts(
      String projectName) async {
    try {
      final res = await _client.getArtifacts(projectName);

      return Right(res
          .getItems(ArtifactResponse.fromJson)
          ?.map((e) => e.toArtifactModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> createArtifact(
      {required String phaseId,
      required String cpe,
      required String name,
      required String url,
      required String version,
      required String type,
      List<String> threatList = const []}) async {
    try {
      await _client.createArtifact(phaseId: phaseId, body: {
        "data": {
          "threatList": threatList,
          "name": name,
          "url": url,
          "version": version,
          "cpe": cpe,
          "type": type
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> updateArtifact(
      {required String artifactId,
      required String cpe,
      required String name,
      required String url,
      required String version,
      required String type,
      List<String> threatList = const []}) async {
    try {
      await _client.updateArtifact(artifactId: artifactId, body: {
        "data": {
          "threatList": threatList,
          "name": name,
          "url": url,
          "version": version,
          "cpe": cpe,
          "type": type
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> deleteArtifacts(
      {required String phaseId, required String artifactId}) async {
    try {
      await _client.deleteArtifact(phaseId, artifactId);

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
