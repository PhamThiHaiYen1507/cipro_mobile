// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMemberInfoModel _$ProjectMemberInfoModelFromJson(Map json) =>
    ProjectMemberInfoModel(
      memberId: json['memberId'] as String,
      name: json['name'] as String?,
      account: json['account'] == null
          ? null
          : AccountInfoModel.fromJson(
              Map<String, dynamic>.from(json['account'] as Map)),
      taskAssigned: (json['taskAssigned'] as List<dynamic>)
          .map((e) =>
              TaskInfoModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      ticketAssigned: json['ticketAssigned'] as List<dynamic>,
      activityHistory: json['activityHistory'] as List<dynamic>,
      projectIn:
          (json['projectIn'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProjectMemberInfoModelToJson(
        ProjectMemberInfoModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'name': instance.name,
      'account': instance.account?.toJson(),
      'taskAssigned': instance.taskAssigned.map((e) => e.toJson()).toList(),
      'ticketAssigned': instance.ticketAssigned,
      'activityHistory': instance.activityHistory,
      'projectIn': instance.projectIn,
    };
