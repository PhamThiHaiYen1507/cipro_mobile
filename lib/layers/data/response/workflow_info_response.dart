import 'package:json_annotation/json_annotation.dart';

part 'workflow_info_response.g.dart';

@JsonSerializable()
class WorkflowInfoResponse {
  String? name;

  String? path;

  String? content;

  String? id;

  String? nodeId;

  String? state;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? url;

  String? htmlUrl;

  String? badgeUrl;

  num? totalRuns;

  List<WorkflowRunInfoResponse>? runs;

  WorkflowInfoResponse();

  factory WorkflowInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfoResponseToJson(this);
}

@JsonSerializable()
class WorkflowRunInfoResponse {
  String? id;

  String? nodeId;

  String? name;

  String? path;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? event;

  String? status;

  String? conclusion;

  String? workflowId;

  WorkflowRunInfoResponse();

  factory WorkflowRunInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkflowRunInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowRunInfoResponseToJson(this);
}
