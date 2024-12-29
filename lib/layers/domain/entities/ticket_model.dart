import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/entities/vulnerability_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final String id;

  final String? title;

  final ProjectMemberInfoModel? assignee;

  final ProjectMemberInfoModel? assigner;

  final String? status;

  final String? description;

  final String? priority;

  final List<VulnerabilityModel> targetedVulnerability;

  final String? projectName;

  final String? createBy;

  final DateTime createdAt;

  final DateTime? updatedAt;

  TicketModel({
    required this.id,
    this.title,
    this.assignee,
    this.assigner,
    this.status,
    this.description,
    this.priority,
    required this.targetedVulnerability,
    this.projectName,
    required this.createdAt,
    this.updatedAt,
    this.createBy,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
