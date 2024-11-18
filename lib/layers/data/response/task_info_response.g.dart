// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInfoResponse _$TaskInfoResponseFromJson(Map json) => TaskInfoResponse()
  ..sId = json['_id'] as String?
  ..name = json['name'] as String?
  ..status = json['status'] as String?
  ..description = json['description'] as String?
  ..projectName = json['projectName'] as String?
  ..dueDate =
      json['dueDate'] == null ? null : DateTime.parse(json['dueDate'] as String)
  ..createdAt = json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String)
  ..updatedAt = json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String);

Map<String, dynamic> _$TaskInfoResponseToJson(TaskInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'projectName': instance.projectName,
      'dueDate': instance.dueDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
