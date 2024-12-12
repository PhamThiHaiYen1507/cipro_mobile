import 'package:json_annotation/json_annotation.dart';

part 'task_info_model.g.dart';

@JsonSerializable()
class TaskInfoModel {
  final String taskId;

  final String? name;

  final String? status;

  final String? description;

  final String? projectName;

  final DateTime? dueDate;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  TaskInfoModel({
    required this.taskId,
    this.name,
    this.status,
    this.description,
    this.projectName,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TaskInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskInfoModelToJson(this);
}
