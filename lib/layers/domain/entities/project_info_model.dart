import 'package:json_annotation/json_annotation.dart';

part 'project_info_model.g.dart';

@JsonSerializable()
class ProjectInfoModel {
  final String projectId;

  final String? name;

  final String? url;

  final String? status;

  final String? createdBy;

  final List<dynamic>? phaseList;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  ProjectInfoModel({
    required this.projectId,
    this.name,
    this.url,
    this.status,
    this.createdBy,
    this.phaseList,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectInfoModelToJson(this);
}
