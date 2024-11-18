import 'package:json_annotation/json_annotation.dart';

part 'workflow_info_response.g.dart';

@JsonSerializable()
class WorkflowInfoResponse {
  String? name;

  String? path;

  String? content;

  WorkflowInfoResponse();

  factory WorkflowInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfoResponseToJson(this);
}
