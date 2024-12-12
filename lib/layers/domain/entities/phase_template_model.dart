import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phase_template_model.g.dart';

@JsonSerializable()
class PhaseTemplateModel {
  final String id;

  final String name;

  final String description;

  final List<PhaseModel> phases;

  final bool isPrivate;

  final String createdBy;

  PhaseTemplateModel({
    required this.id,
    required this.name,
    required this.description,
    required this.phases,
    required this.isPrivate,
    required this.createdBy,
  });

  factory PhaseTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$PhaseTemplateModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhaseTemplateModelToJson(this);
}
