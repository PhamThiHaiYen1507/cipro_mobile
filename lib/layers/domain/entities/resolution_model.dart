import 'package:json_annotation/json_annotation.dart';

part 'resolution_model.g.dart';

@JsonSerializable()
class ResolutionModel {
  final String id;

  final String cveId;

  final List<ResolutionInfoModel> resolution;

  ResolutionModel(
      {required this.id, required this.cveId, required this.resolution});

  factory ResolutionModel.fromJson(Map<String, dynamic> json) =>
      _$ResolutionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResolutionModelToJson(this);
}

@JsonSerializable()
class ResolutionInfoModel {
  final String id;

  final String createdBy;

  final String description;

  ResolutionInfoModel(
      {required this.id, required this.createdBy, required this.description});

  factory ResolutionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ResolutionInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResolutionInfoModelToJson(this);
}
