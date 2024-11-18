// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectInfoModel _$ProjectInfoModelFromJson(Map json) => ProjectInfoModel(
      projectId: json['projectId'] as String,
      name: json['name'] as String?,
      url: json['url'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      phaseList: json['phaseList'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProjectInfoModelToJson(ProjectInfoModel instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'name': instance.name,
      'url': instance.url,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'phaseList': instance.phaseList,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
