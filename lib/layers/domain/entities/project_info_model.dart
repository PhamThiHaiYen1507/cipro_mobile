import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'workflow_info_model.dart';

part 'project_info_model.g.dart';

@JsonSerializable()
class ProjectInfoModel {
  final String projectId;

  final String? name;

  final String? url;

  final String? status;

  final String? createdBy;

  final List<PhaseModel> phaseList;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final List<WorkflowInfoModel> workflows;

  ProjectInfoModel({
    required this.projectId,
    this.name,
    this.url,
    this.status,
    this.createdBy,
    required this.phaseList,
    this.createdAt,
    this.updatedAt,
    required this.workflows,
  });

  factory ProjectInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectInfoModelToJson(this);
}
