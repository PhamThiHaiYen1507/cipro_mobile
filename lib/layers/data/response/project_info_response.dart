import 'package:json_annotation/json_annotation.dart';

part 'project_info_response.g.dart';

@JsonSerializable()
class ProjectInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  String? name;

  String? url;

  String? status;

  String? createdBy;

  List<dynamic>? phaseList;

  DateTime? createdAt;

  DateTime? updatedAt;

  ProjectInfoResponse();

  factory ProjectInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectInfoResponseToJson(this);
}
