import 'package:json_annotation/json_annotation.dart';

part 'project_activity_info_response.g.dart';

@JsonSerializable()
class ProjectActivityInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  DateTime? createdAt;

  String? id;

  String? action;

  String? content;

  String? createdBy;

  String? projectId;

  DateTime? updatedAt;

  ProjectActivityInfoResponse();

  factory ProjectActivityInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectActivityInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectActivityInfoResponseToJson(this);
}
