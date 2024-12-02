import 'package:base_project/layers/data/response/threat_response.dart';
import 'package:base_project/layers/domain/entities/threat_model.dart';
import 'package:base_project/utils/utils.dart';

extension ThreatTranslator on ThreatResponse {
  ThreatModel toThreatModel() => ThreatModel(
        id: id ?? Utils.generateId,
        name: name ?? '',
        type: type ?? ThreatType.spoofing,
        status: status ?? ThreatStatus.nonMitigated,
        description: description ?? '',
        mitigation: mitigation ?? [],
        score: score?.toThreatScoreModel(),
      );
}

extension ThreatScoreTranslator on ThreatScoreResponse {
  ThreatScoreModel toThreatScoreModel() => ThreatScoreModel(
        total: total ?? 0,
        details: details?.toThreatScoreDetailsModel(),
      );
}

extension ThreatScoreDetailsTranslator on ThreatScoreDetailsResponse {
  ThreatScoreDetailsModel toThreatScoreDetailsModel() =>
      ThreatScoreDetailsModel(
        affectedUsers: affectedUsers ?? 0,
        damage: damage ?? 0,
        discoverability: discoverability ?? 0,
        exploitability: exploitability ?? 0,
        reproducibility: reproducibility ?? 0,
      );
}
