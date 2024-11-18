// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activity_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectActivityInfoModel _$ProjectActivityInfoModelFromJson(Map json) =>
    ProjectActivityInfoModel(
      activityId: json['activityId'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
      action: json['action'] as String?,
      content: json['content'] as String?,
      createdBy: json['createdBy'] as String?,
      projectId: json['projectId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProjectActivityInfoModelToJson(
        ProjectActivityInfoModel instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'id': instance.id,
      'action': instance.action,
      'content': instance.content,
      'createdBy': instance.createdBy,
      'projectId': instance.projectId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
