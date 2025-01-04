import 'package:json_annotation/json_annotation.dart';

part 'workflow_info_model.g.dart';

@JsonSerializable()
class WorkflowInfoModel {
  final String name;

  final String path;

  final String content;

  final String? id;

  final String? nodeId;

  final String? state;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String? url;

  final String? htmlUrl;

  final String? badgeUrl;

  final num totalRuns;

  final List<WorkflowRunInfoModel> runs;

  WorkflowInfoModel({
    required this.name,
    required this.path,
    required this.content,
    this.id,
    this.nodeId,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.htmlUrl,
    this.badgeUrl,
    required this.runs,
    this.totalRuns = 0,
  });

  factory WorkflowInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfoModelToJson(this);
}

@JsonSerializable()
class WorkflowRunInfoModel {
  final String? id;

  final String? nodeId;

  final String? name;

  final String? path;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String? event;

  final String? status;

  final String? conclusion;

  final String? workflowId;

  WorkflowRunInfoModel({
    this.id,
    this.nodeId,
    this.name,
    this.path,
    this.createdAt,
    this.updatedAt,
    this.event,
    this.status,
    this.conclusion,
    this.workflowId,
  });

  factory WorkflowRunInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WorkflowRunInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowRunInfoModelToJson(this);
}
