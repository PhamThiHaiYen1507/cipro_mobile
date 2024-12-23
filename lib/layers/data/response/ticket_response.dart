import 'package:base_project/layers/data/response/project_member_info_response.dart';
import 'package:base_project/layers/data/response/vulnerability_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_response.g.dart';

@JsonSerializable()
class TicketResponse {
  @JsonKey(name: '_id')
  String? id;

  String? title;

  ProjectMemberInfoResponse? assignee;

  ProjectMemberInfoResponse? assigner;

  String? status;

  String? description;

  String? priority;

  List<VulnerabilityResponse>? targetedVulnerability;

  String? projectName;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? createBy;

  TicketResponse();

  factory TicketResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TicketResponseToJson(this);

  toActivityHistoryInfoModel() {}
}
