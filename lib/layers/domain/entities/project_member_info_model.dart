import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_member_info_model.g.dart';

@JsonSerializable()
class ProjectMemberInfoModel {
  final String memberId;

  final String? name;

  final AccountInfoModel? account;

  final List<TaskInfoModel> taskAssigned;

  final List<dynamic> ticketAssigned;

  final List<dynamic> activityHistory;

  final List<String> projectIn;

  ProjectMemberInfoModel({
    required this.memberId,
    this.name,
    this.account,
    required this.taskAssigned,
    required this.ticketAssigned,
    required this.activityHistory,
    required this.projectIn,
  });

  factory ProjectMemberInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectMemberInfoModelToJson(this);
}
