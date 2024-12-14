import 'package:base_project/layers/domain/repositories/artifact_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'artifact_item_controller.g.dart';

@injectable
class ArtifactItemController = _ArtifactItemControllerBase
    with _$ArtifactItemController;

abstract class _ArtifactItemControllerBase with Store {
  final ArtifactRepository _artifactRepository;

  _ArtifactItemControllerBase(this._artifactRepository);

  Future<bool> deleteArtifact(String phaseId, String artifactId) async {
    final res = await _artifactRepository.deleteArtifacts(
        phaseId: phaseId, artifactId: artifactId);

    return res.fold((left) => false, (right) => true);
  }

  Future<bool> updateArtifact({
    required String artifactId,
    required String name,
    required String url,
    required String version,
    required String cpe,
    required String type,
  }) async {
    final res = await _artifactRepository.updateArtifact(
        artifactId: artifactId,
        cpe: cpe,
        name: name,
        url: url,
        version: version,
        type: type);

    return res.fold((left) => false, (right) => true);
  }
}
