// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activity_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectActivityInfoResponse _$ProjectActivityInfoResponseFromJson(Map json) =>
    ProjectActivityInfoResponse()
      ..sId = json['_id'] as String?
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String)
      ..id = json['id'] as String?
      ..action = json['action'] as String?
      ..content = json['content'] as String?
      ..createdBy = json['createdBy'] as String?
      ..projectId = json['projectId'] as String?
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String);

Map<String, dynamic> _$ProjectActivityInfoResponseToJson(
        ProjectActivityInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'id': instance.id,
      'action': instance.action,
      'content': instance.content,
      'createdBy': instance.createdBy,
      'projectId': instance.projectId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
