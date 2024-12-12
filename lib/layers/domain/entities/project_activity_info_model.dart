import 'package:json_annotation/json_annotation.dart';

part 'project_activity_info_model.g.dart';

@JsonSerializable()
class ProjectActivityInfoModel {
  final String activityId;

  final DateTime? createdAt;

  final String? id;

  final String? action;

  final String? content;

  final String? createdBy;

  final String? projectId;

  final DateTime? updatedAt;

  ProjectActivityInfoModel(
      {required this.activityId,
      this.createdAt,
      this.id,
      this.action,
      this.content,
      this.createdBy,
      this.projectId,
      this.updatedAt});

  factory ProjectActivityInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectActivityInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectActivityInfoModelToJson(this);
}
