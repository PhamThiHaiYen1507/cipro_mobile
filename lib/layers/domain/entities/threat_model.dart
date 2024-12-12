import 'package:base_project/layers/data/response/threat_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'threat_model.g.dart';

@JsonSerializable()
class ThreatModel {
  final String id;

  final String? name;

  final String? description;

  final ThreatType? type;

  final ThreatScoreModel? score;

  final ThreatStatus? status;

  final List<String>? mitigation;

  ThreatModel({
    required this.id,
    this.name,
    this.description,
    this.type,
    this.score,
    this.status,
    this.mitigation,
  });

  factory ThreatModel.fromJson(Map<String, dynamic> json) =>
      _$ThreatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatModelToJson(this);
}

@JsonSerializable()
class ThreatScoreModel {
  final double total;

  final ThreatScoreDetailsModel? details;

  ThreatScoreModel({required this.total, this.details});

  factory ThreatScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ThreatScoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatScoreModelToJson(this);
}

@JsonSerializable()
class ThreatScoreDetailsModel {
  final int damage;

  final int reproducibility;

  final int exploitability;

  final int affectedUsers;

  final int discoverability;

  ThreatScoreDetailsModel({
    required this.damage,
    required this.reproducibility,
    required this.exploitability,
    required this.affectedUsers,
    required this.discoverability,
  });

  factory ThreatScoreDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ThreatScoreDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThreatScoreDetailsModelToJson(this);
}
