import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phase_model.g.dart';

@JsonSerializable()
class PhaseModel {
  final String? name;

  final String? description;

  final int order;

  final String id;

  final List<TaskInfoModel> tasks;

  final List<ArtifactModel> artifacts;

  final DateTime createdAt;

  final DateTime? updatedAt;

  PhaseModel({
    this.name,
    this.description,
    required this.order,
    required this.id,
    required this.tasks,
    required this.artifacts,
    required this.createdAt,
    this.updatedAt,
  });

  factory PhaseModel.fromJson(Map<String, dynamic> json) =>
      _$PhaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhaseModelToJson(this);
}
