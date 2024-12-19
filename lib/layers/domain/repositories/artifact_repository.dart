import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';

abstract class ArtifactRepository {
  Future<ApiResponseData<List<ArtifactModel>?>> getArtifacts(
      String projectName);

  Future<ApiResponseData<bool>> createArtifact({
    required String phaseId,
    required String cpe,
    required String name,
    required String url,
    required String version,
    required String type,
    List<String> threatList = const [],
  });

  Future<ApiResponseData<bool>> updateArtifact(
      {required String artifactId,
      required String cpe,
      required String name,
      required String url,
      required String version,
      required String type,
      List<String> threatList = const []});

  Future<ApiResponseData<bool>> deleteArtifacts({
    required String phaseId,
    required String artifactId,
  });
}
