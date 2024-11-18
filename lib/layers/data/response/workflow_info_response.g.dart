// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowInfoResponse _$WorkflowInfoResponseFromJson(Map json) =>
    WorkflowInfoResponse()
      ..name = json['name'] as String?
      ..path = json['path'] as String?
      ..content = json['content'] as String?;

Map<String, dynamic> _$WorkflowInfoResponseToJson(
        WorkflowInfoResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'content': instance.content,
    };
