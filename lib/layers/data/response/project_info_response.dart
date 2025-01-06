import 'package:base_project/layers/data/response/workflow_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'phase_response.dart';

part 'project_info_response.g.dart';

@JsonSerializable()
class ProjectInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  String? name;

  String? url;

  String? status;

  String? createdBy;

  List<PhaseResponse>? phaseList;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<WorkflowInfoResponse>? workflows;

  ProjectInfoResponse();

  factory ProjectInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectInfoResponseToJson(this);
}
