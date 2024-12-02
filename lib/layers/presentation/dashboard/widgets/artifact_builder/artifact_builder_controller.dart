import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:base_project/layers/domain/repositories/artifact_repository.dart';
import 'package:mobx/mobx.dart';

part 'artifact_builder_controller.g.dart';

class ArtifactBuilderController = _ArtifactBuilderControllerBase
    with _$ArtifactBuilderController;

abstract class _ArtifactBuilderControllerBase with Store {
  final ArtifactRepository _artifactRepository;

  final String projectName;

  _ArtifactBuilderControllerBase(this._artifactRepository, this.projectName) {
    _getArtifacts();
  }

  @observable
  List<ArtifactModel> artifacts = [];

  @action
  Future<void> _getArtifacts() async {
    final res = await _artifactRepository.getArtifacts(projectName);

    res.map((right) {
      if (right != null) artifacts = right;
    });
  }
}
