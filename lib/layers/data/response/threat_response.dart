import 'package:json_annotation/json_annotation.dart';

part 'threat_response.g.dart';

@JsonSerializable()
class ThreatResponse {
  @JsonKey(name: '_id')
  String? id;

  String? name;

  String? description;

  ThreatType? type;

  ThreatScoreResponse? score;

  ThreatStatus? status;

  List<String>? mitigation;

  ThreatResponse();

  factory ThreatResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatResponseToJson(this);
}

@JsonSerializable()
class ThreatScoreResponse {
  int? total;
  ThreatScoreDetailsResponse? details;

  ThreatScoreResponse();

  factory ThreatScoreResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreatScoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatScoreResponseToJson(this);
}

@JsonSerializable()
class ThreatScoreDetailsResponse {
  int? damage;
  int? reproducibility;
  int? exploitability;
  int? affectedUsers;
  int? discoverability;

  ThreatScoreDetailsResponse();

  factory ThreatScoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreatScoreDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatScoreDetailsResponseToJson(this);
}

enum ThreatType {
  @JsonValue('Spoofing')
  spoofing,
  @JsonValue('Tampering')
  tampering,
  @JsonValue('Repudiation')
  repudiation,
  @JsonValue('Information Disclosure')
  informationDisclosure,
  @JsonValue('Denial of Service')
  denialOfService,
  @JsonValue('Elevation of Privilege')
  elevationOfPrivilege,
}

enum ThreatStatus {
  @JsonValue('Non mitigated')
  nonMitigated('Non mitigated'),
  @JsonValue('Partially mitigated')
  partiallyMitigated('Partially mitigated'),
  @JsonValue('Fully mitigated')
  fullyMitigated('Fully mitigated');

  final String value;

  const ThreatStatus(this.value);
}
