// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowInfoModel _$WorkflowInfoModelFromJson(Map json) => WorkflowInfoModel(
      name: json['name'] as String,
      path: json['path'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$WorkflowInfoModelToJson(WorkflowInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'content': instance.content,
    };
