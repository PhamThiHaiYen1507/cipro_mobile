// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectInfoResponse _$ProjectInfoResponseFromJson(Map json) =>
    ProjectInfoResponse()
      ..sId = json['_id'] as String?
      ..name = json['name'] as String?
      ..url = json['url'] as String?
      ..status = json['status'] as String?
      ..createdBy = json['createdBy'] as String?
      ..phaseList = json['phaseList'] as List<dynamic>?
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String);

Map<String, dynamic> _$ProjectInfoResponseToJson(
        ProjectInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'url': instance.url,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'phaseList': instance.phaseList,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
