// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMemberInfoResponse _$ProjectMemberInfoResponseFromJson(Map json) =>
    ProjectMemberInfoResponse()
      ..sId = json['_id'] as String?
      ..name = json['name'] as String?
      ..account = json['account'] == null
          ? null
          : AccountInfoResponse.fromJson(
              Map<String, dynamic>.from(json['account'] as Map))
      ..taskAssigned = (json['taskAssigned'] as List<dynamic>?)
          ?.map((e) =>
              TaskInfoResponse.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList()
      ..ticketAssigned = json['ticketAssigned'] as List<dynamic>?
      ..activityHistory = json['activityHistory'] as List<dynamic>?
      ..projectIn = (json['projectIn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$ProjectMemberInfoResponseToJson(
        ProjectMemberInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'account': instance.account?.toJson(),
      'taskAssigned': instance.taskAssigned?.map((e) => e.toJson()).toList(),
      'ticketAssigned': instance.ticketAssigned,
      'activityHistory': instance.activityHistory,
      'projectIn': instance.projectIn,
    };
