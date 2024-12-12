import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';

abstract class ArtifactRepository {
  Future<ApiResponseData<List<ArtifactModel>?>> getArtifacts(
      String projectName);
}
