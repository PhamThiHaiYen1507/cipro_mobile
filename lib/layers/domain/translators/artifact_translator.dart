import 'package:base_project/layers/data/response/artifact_response.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:base_project/layers/domain/translators/threat_translator.dart';
import 'package:base_project/layers/domain/translators/vulnerability_translator.dart';
import 'package:base_project/utils/utils.dart';

extension ArtifactTranslator on ArtifactResponse {
  ArtifactModel toArtifactModel() {
    return ArtifactModel(
      id: id ?? Utils.generateId,
      name: name ?? '',
      threatList: threatList?.map((e) => e.toThreatModel()).toList() ?? [],
      vulnerabilityList:
          vulnerabilityList?.map((e) => e.toVulnerabilityModel()).toList() ??
              [],
      type: type ?? ArtifactType.log,
      version: version ?? '',
      cpe: cpe,
      url: url,
    );
  }
}
