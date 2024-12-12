import 'package:base_project/layers/data/response/artifact_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'threat_model.dart';
import 'vulnerability_model.dart';

part 'artifact_model.g.dart';

@JsonSerializable()
class ArtifactModel {
  final String id;

  final String name;

  final ArtifactType type;

  final String? url;

  final String version;

  final List<ThreatModel> threatList;

  final List<VulnerabilityModel> vulnerabilityList;

  final String? cpe;

  ArtifactModel({
    required this.id,
    required this.name,
    required this.type,
    this.url,
    required this.version,
    required this.threatList,
    required this.vulnerabilityList,
    this.cpe,
  });

  factory ArtifactModel.fromJson(Map<String, dynamic> json) =>
      _$ArtifactModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactModelToJson(this);
}
