import 'package:base_project/layers/data/response/account_info_response.dart';
import 'package:base_project/layers/data/response/task_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_member_info_response.g.dart';

@JsonSerializable()
class ProjectMemberInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  String? name;

  AccountInfoResponse? account;

  List<TaskInfoResponse>? taskAssigned;

  List<dynamic>? ticketAssigned;

  List<dynamic>? activityHistory;

  List<String>? projectIn;

  ProjectMemberInfoResponse();

  factory ProjectMemberInfoResponse.fromJson(Map<String, dynamic> json) {
    return _$ProjectMemberInfoResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProjectMemberInfoResponseToJson(this);
}
