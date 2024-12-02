import 'package:base_project/layers/data/response/threat_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'vulnerability_response.dart';

part 'artifact_response.g.dart';

enum ArtifactType {
  @JsonValue('image')
  image,
  @JsonValue('log')
  log,
  @JsonValue('source code')
  sourceCode,
  @JsonValue('executable')
  executable,
  @JsonValue('library')
  library,
}

@JsonSerializable()
class ArtifactResponse {
  @JsonKey(name: '_id')
  String? id;

  String? name;

  ArtifactType? type;

  String? url;

  String? version;

  List<ThreatResponse>? threatList;

  List<VulnerabilityResponse>? vulnerabilityList;

  String? cpe;

  ArtifactResponse();

  factory ArtifactResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtifactResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactResponseToJson(this);
}
