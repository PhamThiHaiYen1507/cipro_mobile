import 'package:base_project/layers/domain/repositories/artifact_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'create_artifact_button_controller.g.dart';

@injectable
class CreateArtifactButtonController = _CreateArtifactButtonControllerBase
    with _$CreateArtifactButtonController;

abstract class _CreateArtifactButtonControllerBase with Store {
  final ArtifactRepository _artifactRepository;

  _CreateArtifactButtonControllerBase(this._artifactRepository);

  Future<bool> createArtifact({
    required String phaseId,
    required String name,
    required String url,
    required String version,
    required String cpe,
    required String type,
  }) async {
    final res = await _artifactRepository.createArtifact(
        phaseId: phaseId,
        cpe: cpe,
        name: name,
        url: url,
        version: version,
        type: type);

    return res.fold((left) => false, (right) => true);
  }
}
