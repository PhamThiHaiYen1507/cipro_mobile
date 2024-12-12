import 'package:json_annotation/json_annotation.dart';

part 'task_info_response.g.dart';

@JsonSerializable()
class TaskInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  String? name;

  String? status;

  String? description;

  String? projectName;

  DateTime? dueDate;

  DateTime? createdAt;

  DateTime? updatedAt;

  TaskInfoResponse();

  factory TaskInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskInfoResponseToJson(this);
}
